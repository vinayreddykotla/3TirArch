# Version
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.40.0"
    }
  }


}
# Authentication to AWS from terraform code
provider "aws" {
  region  = "us-east-1"
  profile = "default"
}
terraform {
  backend "s3" {
    bucket = "vin-dev-project"
    key    = "projects_statefile/infra_dev/terraform.state"
    region = "us-east-1"
  }
}

# VPC
resource "aws_vpc" "vinaydevops_vpc" {
  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name       = "vinaydevops_vpc"
    Created_by = "Terraform"
  }
}
# subnet
resource "aws_subnet" "vinaydevops_public_subnet1" {
  vpc_id                  = aws_vpc.vinaydevops_vpc.id
  cidr_block              = "10.0.1.0/28"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name       = "vinaydevops_public_subnet1"
    created_by = "terraform"
  }
}
resource "aws_subnet" "vinaydevops_public_subnet2" {
  vpc_id                  = aws_vpc.vinaydevops_vpc.id
  cidr_block              = "10.0.2.0/28"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name       = "vinaydevops_public_subnet2"
    created_by = "terraform"
  }
}
#private

resource "aws_subnet" "vinaydevops_private_subnet1" {
  vpc_id     = aws_vpc.vinaydevops_vpc.id
  cidr_block = "10.0.3.0/28"

  availability_zone = "us-east-1a"

  tags = {
    Name       = "vinaydevops_private_subnet1"
    created_by = "terraform"
  }
}
resource "aws_subnet" "vinaydevops_private_subnet2" {
  vpc_id     = aws_vpc.vinaydevops_vpc.id
  cidr_block = "10.0.4.0/28"

  availability_zone = "us-east-1b"

  tags = {
    Name       = "vinaydevops_private_subnet2"
    created_by = "terraform"
  }
}
resource "aws_subnet" "vinaydevops_private_subnet3" {
  vpc_id     = aws_vpc.vinaydevops_vpc.id
  cidr_block = "10.0.5.0/28"

  availability_zone = "us-east-1a"

  tags = {
    Name       = "vinaydevops_private_subnet3"
    created_by = "terraform"
  }
}
resource "aws_subnet" "vinaydevops_private_subnet4" {
  vpc_id     = aws_vpc.vinaydevops_vpc.id
  cidr_block = "10.0.6.0/28"

  availability_zone = "us-east-1b"

  tags = {
    Name       = "vinaydevops_private_subnet4"
    created_by = "terraform"
  }
}

resource "aws_subnet" "vinaydevops_private_subnet5" {
  vpc_id     = aws_vpc.vinaydevops_vpc.id
  cidr_block = "10.0.7.0/28"

  availability_zone = "us-east-1a"

  tags = {
    Name       = "vinaydevops_private_subnet5"
    created_by = "terraform"
  }
}
resource "aws_subnet" "vinaydevops_private_subnet6" {
  vpc_id     = aws_vpc.vinaydevops_vpc.id
  cidr_block = "10.0.8.0/28"

  availability_zone = "us-east-1b"

  tags = {
    Name       = "vinaydevops_private_subnet6"
    created_by = "terraform"
  }
}

# IGW
resource "aws_internet_gateway" "vinaydevops_igw" {
  vpc_id = aws_vpc.vinaydevops_vpc.id

  tags = {
    Name       = "vinaydevops_igw"
    Created_By = "Terraform"
  }
}

# RTB
resource "aws_route_table" "vinaydevops_rtb_public" {
  vpc_id = aws_vpc.vinaydevops_vpc.id

  tags = {
    Name       = "vinaydevops_rtb_public"
    Created_By = "Teerraform"
  }
}
resource "aws_route_table" "vinaydevops_rtb_private" {
  vpc_id = aws_vpc.vinaydevops_vpc.id

  tags = {
    Name       = "vinaydevops_rtb_private"
    Created_By = "Teerraform"
  }
}

# Create the internet Access 

resource "aws_route" "vinaydevops_rtb_igw" {
  route_table_id         = aws_route_table.vinaydevops_rtb_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vinaydevops_igw.id

}

resource "aws_route_table_association" "vinaydevops_subnet_association1" {
  subnet_id      = aws_subnet.vinaydevops_public_subnet1.id
  route_table_id = aws_route_table.vinaydevops_rtb_public.id
}

resource "aws_route_table_association" "vinaydevops_subnet_association2" {
  subnet_id      = aws_subnet.vinaydevops_public_subnet2.id
  route_table_id = aws_route_table.vinaydevops_rtb_public.id
}

resource "aws_route_table_association" "vinaydevops_subnet_association3" {
  subnet_id      = aws_subnet.vinaydevops_private_subnet1.id
  route_table_id = aws_route_table.vinaydevops_rtb_private.id
}

resource "aws_route_table_association" "vinaydevops_subnet_association4" {
  subnet_id      = aws_subnet.vinaydevops_private_subnet2.id
  route_table_id = aws_route_table.vinaydevops_rtb_private.id
}

resource "aws_route_table_association" "vinaydevops_subnet_association5" {
  subnet_id      = aws_subnet.vinaydevops_private_subnet3.id
  route_table_id = aws_route_table.vinaydevops_rtb_private.id
}

resource "aws_route_table_association" "vinaydevops_subnet_association6" {
  subnet_id      = aws_subnet.vinaydevops_private_subnet4.id
  route_table_id = aws_route_table.vinaydevops_rtb_private.id
}

resource "aws_route_table_association" "vinaydevops_subnet_association7" {
  subnet_id      = aws_subnet.vinaydevops_private_subnet5.id
  route_table_id = aws_route_table.vinaydevops_rtb_private.id
}

resource "aws_route_table_association" "vinaydevops_subnet_association8" {
  subnet_id      = aws_subnet.vinaydevops_private_subnet6.id
  route_table_id = aws_route_table.vinaydevops_rtb_private.id
}


# Elastic Ipaddress for NAT Gateway
resource "aws_eip" "vinaydevops_eip" {
  vpc = true
}

# Create Nat Gateway 
resource "aws_nat_gateway" "vinaydevops_gw" {
  allocation_id = aws_eip.vinaydevops_eip.id
  subnet_id     = aws_subnet.vinaydevops_public_subnet1.id

  tags = {
    Name      = "Nat Gateway"
    Createdby = "Terraform"
  }
}

# Allow internet access from NAT Gateway to Private Route Table
resource "aws_route" "vinaydevops_rtb_private_gw" {
  route_table_id         = aws_route_table.vinaydevops_rtb_private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.vinaydevops_gw.id
}

# Network Access Control List 
resource "aws_network_acl" "vinaydevops_nsg" {
  vpc_id = aws_vpc.vinaydevops_vpc.id
  subnet_ids = [
    "${aws_subnet.vinaydevops_public_subnet1.id}",
    "${aws_subnet.vinaydevops_public_subnet2.id}",
    "${aws_subnet.vinaydevops_private_subnet1.id}",
    "${aws_subnet.vinaydevops_private_subnet2.id}",
    "${aws_subnet.vinaydevops_private_subnet3.id}",
    "${aws_subnet.vinaydevops_private_subnet4.id}",
    "${aws_subnet.vinaydevops_private_subnet5.id}",
    "${aws_subnet.vinaydevops_private_subnet6.id}"
  ]

  # All ingress port 22 
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }
  # Allow ingress of port 80
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }
  # Allow ingress of port 80
  ingress {
    protocol   = "tcp"
    rule_no    = 400
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 3389
    to_port    = 3389
  }
  # Allow ingress of ports from 1024 to 65535
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  # Allow egress of port 22
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }
  # Allow egress of port 80
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }
  # Allow egress of port 80
  egress {
    protocol   = "tcp"
    rule_no    = 400
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 3389
    to_port    = 3389
  }
  # Allow egress of ports from 1024 to 65535
  egress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  tags = {
    Name      = "vinaydevops_nsg"
    createdby = "Terraform"
  }
}

# EC2 instance Security group
resource "aws_security_group" "vinaydevops_sg_bastion" {
  vpc_id      = aws_vpc.vinaydevops_vpc.id
  name        = "sg_vinaydevops_ssh_rdp"
  description = "To Allow SSH From IPV4 Devices"

  # Allow Ingress / inbound Of port 22 
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  # Allow Ingress / inbound Of port 8080 
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
  }
  # Allow egress / outbound of all ports 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "vinaydevops_sg_bastion"
    Description = "vinaydevops allow SSH - RDP"
    createdby   = "terraform"
  }

}

# EC2 instance Security group
resource "aws_security_group" "vinaydevops_sg" {
  vpc_id      = aws_vpc.vinaydevops_vpc.id
  name        = "sg_vinaydevops_ssh"
  description = "To Allow SSH From IPV4 Devices"

  # Allow Ingress / inbound Of port 22 
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  # Allow Ingress / inbound Of port 80 
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
  # Allow Ingress / inbound Of port 8080 
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
  }
  # Allow egress / outbound of all ports 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "vinaydevops_sg"
    Description = "vinaydevops allow SSH - HTTP and Jenkins"
    createdby   = "terraform"
  }

}

# Bastion - Windows 
resource "aws_instance" "vinaydevops_bastion" {
  ami                    = "ami-06938c7701be658b4"
  instance_type          = "t2.micro"
  key_name               = "nv_sshkeys"
  subnet_id              = aws_subnet.vinaydevops_public_subnet1.id
  vpc_security_group_ids = ["${aws_security_group.vinaydevops_sg_bastion.id}"]
  tags = {
    Name      = "vinaydevops_Bastion"
    CreatedBy = "Terraform"
  }
}

# WebServer - Private Subnet 
resource "aws_instance" "vinaydevops_web" {
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t2.micro"
  key_name               = "nv_sshkeys"
  subnet_id              = aws_subnet.vinaydevops_private_subnet1.id
  vpc_security_group_ids = ["${aws_security_group.vinaydevops_sg.id}"]
  user_data              = file("web.sh")
  tags = {
    Name      = "vinaydevops_webserver"
    CreatedBy = "Terraform"
  }
}

output "vpc_id" {
  value = aws_vpc.vinaydevops_vpc.id
}


