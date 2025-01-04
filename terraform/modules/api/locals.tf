locals {
  docker_image_url="${var.region}-docker.pkg.dev/testmap-417607/${var.registry_name}/${var.name}-image:${formatdate("YYYYMMDDhhmmssZ",timestamp())}"
}