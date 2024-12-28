resource "google_storage_bucket" "demo_bucket" {
  name          = "chiradev-demo-bucket"
  location      = "us-east1"
  force_destroy = true

  soft_delete_policy {
    retention_duration_seconds = 0
  }
}

