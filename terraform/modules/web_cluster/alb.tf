locals {
  # build the list of web servers the alb should send traffic to
  web_servers         = [for container in docker_container.web_server : "server ${container.name}"]
  web_server_entries  = join(";", local.web_servers)
  conf_container_path = "/etc/nginx/alb.conf"
  conf_host_path      = "${abspath(path.root)}/modules/web_cluster/templates/alb.conf"
  alb_name            = "${var.name}-alb"
}

resource "docker_image" "alb" {
  name         = "nginx:${var.alb_version}"
  keep_locally = true
}

resource "docker_container" "alb" {
  image = docker_image.alb.image_id
  name  = local.alb_name

  # The healthcheck endpoint is defined at templates/alb.conf
  healthcheck {
    test = ["CMD", "curl", "-f", "localhost/healthcheck"]
  }

  ports {
    # should match http.server.listen
    internal = 80
    external = var.alb_port
  }

  # Add our custom nginx conf to the container
  volumes {
    container_path = local.conf_container_path
    host_path      = local.conf_host_path
    read_only      = true
  }

  networks_advanced {
    name = docker_network.cluster.id
  }

  # Replace ALL environment variables present in the local.conf_container_path by their actual 
  # value. This is useful for injecting things created dynamically, such as web servers and the 
  # name of the alb.
  # 0. Populate the environment variables from alb.conf
  # these two environment variables are used to inject content into the nginx conf
  env = ["WEB_SERVER_ENTRIES=${local.web_server_entries}", "ALB_NAME=${local.alb_name}"]
  # 1. Replace the env vars
  provisioner "local-exec" {
    command = "docker exec ${local.alb_name} /bin/bash -c 'envsubst < ${local.conf_container_path} > /etc/nginx/nginx.conf'"
  }
  # 2. Make nginx use the new config
  provisioner "local-exec" {
    command = "docker exec ${local.alb_name} nginx -s reload"
  }
}
