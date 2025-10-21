output "workload_identity_pool_name" {
  description = "The name of the workload identity pool."
  value       = google_iam_workload_identity_pool.wid_pool.name
}

output "workload_identity_provider_name" {
  description = "The name of the workload identity pool provider."
  value       = google_iam_workload_identity_pool_provider.github_provider.name
}