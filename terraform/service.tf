resource "docker_image" "chiradev_demo" {
  name = "us-east1-docker.pkg.dev/testmap-417607/${google_artifact_registry_repository.registry.name}/chiradev-demo-tf"
  build {
    context = "../src/"
  }
} 

resource "google_artifact_registry_repository" "registry" {
  location      = "us-east1"
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
  location = "us-east1"
  template {
    spec {
      containers {
        image = docker_registry_image.chiradev_image.name
      }
    }
  }
  depends_on = [ docker_registry_image.chiradev_image ]
}