variable "subnet_public_cidrs" {
  type = list(string)
}
variable "subnet_private_cidrs" {
    type = list(string)
}
variable "project" {
  type = string
}
variable region {
  type = string
}
variable environment {
  type = string
}