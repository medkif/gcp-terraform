output "service_account_email" {
  description = "The email of the created service account."
  value       = google_service_account.sa.email
}

output "service_account_id" {
  description = "The unique ID of the service account."
  value       = google_service_account.sa.account_id
}