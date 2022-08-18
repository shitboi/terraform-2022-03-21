variable "region" {}
variable "vpc_cidr" {}
variable "env" {
  type = string
  default = "dev"
}
variable "private_subnet_cidr" {}
variable "public_subnet_cidr" {}
variable "instance_type" {}
variable "avail_zone" {}
variable "aws_access_key" {
  default = ""
}
variable "aws_secret_key" {
  default = ""
}
