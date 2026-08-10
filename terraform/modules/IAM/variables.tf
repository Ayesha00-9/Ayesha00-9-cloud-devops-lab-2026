variable "project_name" {
  description = "Project name"
  type        = string
}

variable "jenkins_username" {
  description = "Jenkins username stored in SSM Parameter Store"
  type        = string
  sensitive   = true
}

variable "jenkins_password" {
  description = "Jenkins password stored in SSM Parameter Store"
  type        = string
  sensitive   = true
}