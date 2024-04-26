variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "instance_version" {
  type = string
  default = "POSTGRES_15"
}

variable "tier" {
  type = string
  default = "db-f1-micro"
}

variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type = string
}