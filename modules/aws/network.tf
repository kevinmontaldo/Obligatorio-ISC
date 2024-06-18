resource "aws_vpc" "vpc_obligatorio" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-obligatorio"
  }
}

resource "aws_subnet" "subnet_A_obligatorio" {
  vpc_id                  = aws_vpc.vpc_obligatorio.id 
  cidr_block              = var.subnet_A         
  availability_zone       = var.az_1          
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-A-obligatorio"
  }
}

resource "aws_subnet" "subnet_B_obligatorio" {
  vpc_id                  = aws_vpc.vpc_obligatorio.id 
  cidr_block              = var.subnet_B        
  availability_zone       = var.az_2            
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-B-obligatorio"
  }
}
resource "aws_internet_gateway" "ig_obligatorio" {
  vpc_id = aws_vpc.vpc_obligatorio.id
}


resource "aws_route_table" "default_rt" {
  vpc_id = aws_vpc.vpc_obligatorio.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_obligatorio.id
  }

  tags = {
    Name = "default_rt_obligatorio"
  }
}