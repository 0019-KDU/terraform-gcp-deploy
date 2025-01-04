output "url" {
    value = google_cloud_run_service.chiradev_service.status[0].url
}