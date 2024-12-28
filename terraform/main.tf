terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.14.1"
    }
  }
}

provider "google" {
  project     = "testmap-417607"
  region      = "us-east1"
}