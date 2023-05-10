resource "docker_network" "cluster" {
  name = "${var.name}-network"
}
