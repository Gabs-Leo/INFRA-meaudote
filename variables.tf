variable "project" {
  type = string
}

variable "region" {
  type = string
  default = "us-central1"
}

variable "subnet_public_cidrs" {
  type = list(string)
  default = ["10.46.0.0/16", "10.47.0.0/16"]
}
variable "subnet_private_cidrs" {
  type = list(string)
  default = ["10.49.0.0/16", "10.50.0.0/16"]
}

variable "db_user" {
  type = string
  sensitive = true
}

variable "db_password" {
  type = string
  sensitive = true
}

variable "ssh_user" {
  type = string
  sensitive = true
}

variable "ssh_public_key" {
  type = string
  sensitive = true
}

variable "env_variables" {
  type = list(object({
    key = string
    value = string
  }))
}