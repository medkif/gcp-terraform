resource "google_firestore_database" "database" {
  project     = var.project_id
  name        = var.firestore_db_name
  location_id = var.region
  type        = "FIRESTORE_NATIVE"
}

resource "google_firestore_document" "mydoc" {
  project     = var.project_id
  database    = google_firestore_database.database.name
  collection  = "drafts"
  document_id = "my-doc-id"
  fields = jsonencode({
      text = {stringValue = "Deployed via Terraform"}
      timestamp = {timestampValue = timestamp()}
    }
  )
}