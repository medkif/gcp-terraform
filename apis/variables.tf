variable "project_id" {
  type = string
}
variable "required_apis" {
  description = "List of APIs to enable for the project"
  type        = list(string)
}