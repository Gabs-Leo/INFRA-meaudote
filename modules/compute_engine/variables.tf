variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "machine_type" {
  type = string
  default = "e2-micro"
}

variable "zone" {
  type = string
  default = "us-central1-a"
}

variable "tags" {
  type = list(string)
}

variable "subnetwork_id" {
  type = string
}

variable "gce_ssh_user" {
  type = string
}

variable "gce_ssh_pub_key_file" {
  type = string
  sensitive = true
}

variable "startup_script" {
  type = string
  default = "default.sh"
}

