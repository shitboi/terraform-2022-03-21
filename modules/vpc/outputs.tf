output "vpc-id" {
  value = aws_vpc.myapp-vpc
}

output "gw-id" {
  value = aws_internet_gateway.gw
}