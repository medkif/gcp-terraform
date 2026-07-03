variable "project_id" {
  type = string
}
variable "project_number" {
  type = string
}
variable "workload_identity_pool_id" {
  type = string
  default = "pool"
}
variable "service_account_email" {
  type = string
}
variable "github_owner" {
  type = string
}
variable "github_repo" {
  type = string
}