variable "resource_group_name" {}
variable "location" {}
variable "subnet_id" {}
variable "vm_size" {}
variable "vm_name" {}
variable "environment" {}
variable "tags" {}

variable "admin_password" {
  description = "Admin password for VM"
  type        = string
  sensitive   = true
}