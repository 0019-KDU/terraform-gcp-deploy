locals {
  docker_image_url="${var.region}-docker.pkg.dev/testmap-417607/${google_artifact_registry_repository.registry.name}/chiradev-demo-tf:${formatdate("YYYYMMDDhhmmssZ",timestamp())}"
}