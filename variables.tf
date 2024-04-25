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