resource "aws_vpc" "vpc-obligatorio" {
  cidr_block           = var.vpc-cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-obligatorio"
  }
}

resource "aws_subnet" "subnet-A-obligatorio" {
  vpc_id                  = aws_vpc.vpc-obligatorio.id 
  cidr_block              = var.subnet-A         
  availability_zone       = var.az-1          
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-A-obligatorio"
  }
}

resource "aws_subnet" "subnet-B-obligatorio" {
  vpc_id                  = aws_vpc.vpc-obligatorio.id 
  cidr_block              = var.subnet-B        
  availability_zone       = var.az-2            
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-B-obligatorio"
  }
}
resource "aws_internet_gateway" "ig-obligatorio" {
  vpc_id = aws_vpc.vpc-obligatorio.id
}


resource "default_route_table" "default-route-table" {
  default_route_table_id = aws_vpc.vpc-obligatorio.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig-obligatorio.id
  }
  tags = {
    Name = "default-route-table-obligatorio"
  }
}
