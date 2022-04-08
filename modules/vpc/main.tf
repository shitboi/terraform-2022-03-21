resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.myapp-vpc.id

  tags = {
    Name = "${var.env}-igw"
  }
}