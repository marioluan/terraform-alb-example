resource "docker_image" "web_server" {
  name         = "web-server:${var.web_server_version}"
  keep_locally = true
}

locals {
  name_prefix = "${var.name}-web-server"
}

resource "docker_container" "web_server" {
  count = var.web_server_count
  name  = "${local.name_prefix}-${count.index}"
  image = docker_image.web_server.image_id
  env   = ["WEB_SERVER_NAME=${local.name_prefix}-${count.index}"]

  networks_advanced {
    name = docker_network.cluster.id
  }
}
