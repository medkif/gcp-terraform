
#-----------
# Workload Identity Pool
#-----------

resource "google_iam_workload_identity_pool" "wid_pool" {
  display_name              = "Github Pool for ${var.github_repo}."
  description               = "Basic Identity pool created by terraform."
  workload_identity_pool_id = var.workload_identity_pool_id
}

resource "google_iam_workload_identity_pool_provider" "github_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.wid_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"
  display_name                       = "Github Provider ${var.github_repo}."
  description                        = "GitHub Actions identity pool provider for automated test"
  disabled                           = false
  attribute_condition = "assertion.repository == \"${var.github_owner}/${var.github_repo}\""
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.aud"        = "assertion.aud"
    "attribute.repository" = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
  depends_on = [google_iam_workload_identity_pool.wid_pool]
}

# Allow GitHub OIDC to impersonate the service account
resource "google_service_account_iam_member" "github_oidc_binding" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.service_account_email}"
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/projects/${var.project_number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.wid_pool.workload_identity_pool_id}/attribute.repository/${var.github_owner}/${var.github_repo}"
  depends_on = [google_iam_workload_identity_pool.wid_pool]
}

# Allow GitHub OIDC to mint an access token for that impersonation
resource "google_service_account_iam_member" "github_oidc_token_creator" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.service_account_email}"
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "principalSet://iam.googleapis.com/projects/${var.project_number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.wid_pool.workload_identity_pool_id}/attribute.repository/${var.github_owner}/${var.github_repo}"
}