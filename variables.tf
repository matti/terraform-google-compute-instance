variable "region" {}

variable "amount" {}
variable "name_prefix" {}
variable "machine_type" {}
variable "user_data" {}

variable "network" {
  default = "default"
}

variable "disk_type" {
  default = "pd-ssd"
}

variable "disk_size" {}
variable "disk_image" {}

variable "disk_create_local_exec_command_or_fail" {
  default = ":"
}

variable "disk_create_local_exec_command_and_continue" {
  default = ":"
}

variable "disk_destroy_local_exec_command_or_fail" {
  default = ":"
}

variable "disk_destroy_local_exec_command_and_continue" {
  default = ":"
}
