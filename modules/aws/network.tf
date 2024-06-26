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
    Name = "subnet_A_obligatorio"
  }
}

resource "aws_subnet" "subnet_B_obligatorio" {
  vpc_id                  = aws_vpc.vpc_obligatorio.id 
  cidr_block              = var.subnet_B        
  availability_zone       = var.az_2            
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet_B_obligatorio"
  }
}
resource "aws_internet_gateway" "ig_obligatorio" {
  vpc_id = aws_vpc.vpc_obligatorio.id
}

resource "aws_route" "ruta_a_internet" {
  route_table_id         = aws_vpc.vpc_obligatorio.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig_obligatorio.id
}
