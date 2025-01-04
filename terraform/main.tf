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

//below i methioned the code for terraform state save another place
# terraform {
#   backend "gcs" {
#     bucket = "bucket name"
#     prefix="terraform/state" 
#   }
# }

provider "google" {
  project     = "testmap-417607"
  region      = var.region
}

data "google_client_config" "default"{
} 

provider "docker" {
  registry_auth {
    address = "${var.region}-docker.pkg.dev"
    username = "oauth2accesstoken"
    password = data.google_client_config.default.access_token
  }
}
resource "google_artifact_registry_repository" "registry" {
  location      = var.region
  repository_id = "chiradev-demo-repo"
  format        = "DOCKER"
}

module "api1" {
  source = "./modules/api"
  name = "chiradev-service"
  region = var.region
  registry_name= google_artifact_registry_repository.registry.name
  depends_on = [ google_artifact_registry_repository.registry ]
}

module "api2" {
  source = "./modules/api"
  name = "chiradev-service-super"
  region = var.region
  registry_name= google_artifact_registry_repository.registry.name
  depends_on = [ google_artifact_registry_repository.registry ]
}

