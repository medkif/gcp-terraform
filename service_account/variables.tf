variable "service_account_id" {
  type = string
}
variable "user_email" {
  type = string
}
variable "project_id" {
  type = string
}
variable "sa_roles" {
  description = "List of roles to give the service account."
  type = list(string)
}