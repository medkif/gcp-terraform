#-----------
# Enable APIs
#-----------

resource "google_project_service" "apis" {
  for_each = toset(var.required_apis)
  project  = var.project_id
  service  = each.value

  disable_on_destroy = true
}