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

provider "google" {
  project     = "testmap-417607"
  region      = "us-east1"
}

data "google_client_config" "default"{
} 

provider "docker" {
  registry_auth {
    address = "us-east1-docker.pkg.dev"
    username = "oauth2accesstoken"
    password = data.google_client_config.default.access_token
  }
}