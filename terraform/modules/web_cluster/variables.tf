variable "web_server_count" {
  type        = number
  description = "number of web servers to launch"
}

variable "web_server_version" {
  default     = "latest"
  type        = string
  description = "the version of the web server to deploy"
}

variable "alb_version" {
  default     = "1.24.0"
  type        = string
  description = "version of the alb to be deployed"
}

variable "alb_port" {
  default     = 80
  type        = number
  description = "port the alb should listen to traffic from"
}

variable "name" {
  type        = string
  description = "a name to be given to the cluster"
}
