# CLUSTER A
module "cluster_a" {
  source = "./modules/web_cluster"

  name               = "cluster_a"
  alb_port           = 80
  alb_version        = "1.24.0"
  web_server_count   = 3
  web_server_version = "latest"
}

output "cluster_a_servers" {
  value = module.cluster_a.web_servers.*.name
}

output "cluster_a_alb" {
  value = module.cluster_a.alb.name
}

# CLUSTER B
module "cluster_b" {
  source = "./modules/web_cluster"

  name               = "cluster_b"
  alb_port           = 8080
  alb_version        = "1.24.0"
  web_server_count   = 3
  web_server_version = "latest"
}


output "cluster_b_servers" {
  value = module.cluster_b.web_servers.*.name
}

output "cluster_b_alb" {
  value = module.cluster_b.alb.name
}
