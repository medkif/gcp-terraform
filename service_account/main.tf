#-----------
# Service Account
#-----------
resource "google_service_account" "sa" {
  account_id   = var.service_account_id
  display_name = "Service Account created by terraform."
}

#-----------
# IAM
#-----------

# 1.1 Service Account User: Grant a user permission to act as or use a specific service account.
resource "google_service_account_iam_binding" "service_account_user__iam" {
  service_account_id = google_service_account.sa.name # Target SA (what sa to act as)
  role               = "roles/iam.serviceAccountUser"

  members = [
    "user:${var.user_email}", # Bind the role to the specified user.
  ]
}

# # 1.2 Workload Identity User: Grants the same user the ability to impersonate the service account via Workload Identity.
resource "google_service_account_iam_binding" "workload_identity_user_iam" {
  service_account_id = google_service_account.sa.name
  role               = "roles/iam.workloadIdentityUser"
  
  members = [
    "user:${var.user_email}",
  ]
}

resource "google_project_iam_member" "sa_roles" {
  for_each = toset(var.sa_roles)
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.sa.email}"
}