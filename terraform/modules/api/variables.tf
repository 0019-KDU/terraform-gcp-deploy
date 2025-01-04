variable "region" {
  description = "The region in which to create the resources"
  type        = string
}

variable "name" {
  description = "name of the service"
  type        = string
}

variable "registry_name" {
  description = "The name of the artifact registry repository"
  type        = string 
}

variable "port" {
  description = "The port on which the service will listen"
  type        = number
  default     = 8080
}