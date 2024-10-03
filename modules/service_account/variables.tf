variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "sufix" {
  type = string
  default = ""
}

variable "roles" {
  type = list(string)
  default = [ "roles/iam.serviceAccountUser" ]
}