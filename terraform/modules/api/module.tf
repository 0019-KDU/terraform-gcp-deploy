terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.14.1"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

resource "docker_image" "chiradev_demo" {
  name = local.docker_image_url
  build {
    context = abspath("${path.root}/../src/")
  }
} 


resource "docker_registry_image" "chiradev_image" {
  name          = docker_image.chiradev_demo.name
  keep_remotely = true
  depends_on = [ docker_image.chiradev_demo ]
}

resource "google_cloud_run_service" "chiradev_service" {
  name = var.name
  location = var.region
  template {
    spec {
      containers {
        image = docker_registry_image.chiradev_image.name
        ports {
          container_port = var.port
        }
      }
    }
  }
  depends_on = [ docker_registry_image.chiradev_image ]
}