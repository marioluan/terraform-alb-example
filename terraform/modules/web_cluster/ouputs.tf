output "web_servers" {
  value = docker_container.web_server
}

output "alb" {
  value = docker_container.alb
}
