variable "region" {}
variable "vpc_cidr" {}
variable "env" {
  type = string
  default = "dev"
}
variable "private_subnet_cidr" {}
variable "public_subnet_cidr" {}
variable "instance_type" {}
variable "public_key_location" {}
variable "avail_zone" {}
variable "private_key_location" {}