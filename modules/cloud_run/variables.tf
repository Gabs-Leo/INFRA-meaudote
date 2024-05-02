variable region {
  type = string
}

variable project {
  type = string
}

variable environment {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "container_port" {
  type = string
  default = "80"
}

variable "registry_name" {
  type = string
}

variable "env_variables" {
  type = list(object({
    key = string
    value = string
  }))
}

variable "database_host" {
  type = string
  default = ""
}