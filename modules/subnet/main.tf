
resource "aws_subnet" "myapp_public_subnet" {
  vpc_id = var.myapp-vpc-id
  cidr_block = var.public_subnet_cidr
  availability_zone = var.avail_zone
  tags = {
    Name = "${var.env}-public_subnet"
  }
}

resource "aws_subnet" "myapp_private_subnet" {
  vpc_id = var.myapp-vpc-id
  cidr_block = var.private_subnet_cidr
  availability_zone = var.avail_zone
  tags = {
    Name = "${var.env}-private_subnet"
  }
}

resource "aws_route_table" "public_myapp-route-table" {
  vpc_id = var.myapp-vpc-id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gw-id
  }

  tags = {
    Name = "${var.env}-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  route_table_id = aws_route_table.public_myapp-route-table.id
  subnet_id = aws_subnet.myapp_public_subnet.id
}

resource "aws_route_table" "private_myapp-route-table" {
  vpc_id = var.myapp-vpc-id

  tags = {
    Name = "${var.env}-route-table"
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  route_table_id = aws_route_table.private_myapp-route-table.id
  subnet_id = aws_subnet.myapp_private_subnet.id
}
