resource "docker_image" "chiradev_demo" {
  name = local.docker_image_url
  build {
    context = "../src/"
  }
} 

resource "google_artifact_registry_repository" "registry" {
  location      = var.region
  repository_id = "chiradev-demo-repo"
  format        = "DOCKER"
}

resource "docker_registry_image" "chiradev_image" {
  name          = docker_image.chiradev_demo.name
  keep_remotely = true
  depends_on = [ docker_image.chiradev_demo,google_artifact_registry_repository.registry ]
}

resource "google_cloud_run_service" "chiradev_service" {
  name = "chiradev-service"
  location = var.region
  template {
    spec {
      containers {
        image = docker_registry_image.chiradev_image.name
      }
    }
  }
  depends_on = [ docker_registry_image.chiradev_image ]
}