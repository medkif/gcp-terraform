output "artifact_registry_repository" {
  description = "Artifact Registry repository URL."
  value       = google_artifact_registry_repository.my_repo.repository_id
}