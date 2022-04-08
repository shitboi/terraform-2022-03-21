
data "aws_ami" "latest_ami_image" {
  most_recent      = true
  #  name_regex       = "^amzn2-ami-hvm-\\d{3}"
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "public_ec2" {
  ami = data.aws_ami.latest_ami_image.id
  instance_type = var.instance_type

  subnet_id = var.aws-public-subnet-id
  vpc_security_group_ids = [aws_security_group.public_ec2_sg.id]
  availability_zone = var.avail_zone
  associate_public_ip_address = true
  key_name = aws_key_pair.ssh-key.key_name
  #  user_data = file("entry-script.sh")

  connection {
    type = "ssh"
    host = self.public_ip
    user = "ec2-user"
    private_key = file(var.private_key_location)
  }
  //to copy te file to remote

  tags = {
    Name = "${var.env}-public_ec2"
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name = "dev-key"
  public_key = file(var.public_key_location)
}

resource "aws_security_group" "public_ec2_sg" {
  name        = "${var.env}-public_ec2-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = var.myapp-vpc-id

  ingress {
    description      = "SSH to VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTP to VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-public_ec2_sg"
  }
}