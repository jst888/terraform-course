# Internet VPC
resource "aws_vpc" "prod" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "prod"
  }
}

# Subnets
resource "aws_subnet" "prod-public-1" {
  vpc_id                  = aws_vpc.prod.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "prod-public-1"
  }
}

resource "aws_subnet" "prod-public-2" {
  vpc_id                  = aws_vpc.prod.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-southeast-1b"

  tags = {
    Name = "prod-public-2"
  }
}

resource "aws_subnet" "prod-public-3" {
  vpc_id                  = aws_vpc.prod.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-southeast-1c"

  tags = {
    Name = "prod-public-3"
  }
}

resource "aws_subnet" "prod-private-1" {
  vpc_id                  = aws_vpc.prod.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "prod-private-1"
  }
}

resource "aws_subnet" "prod-private-2" {
  vpc_id                  = aws_vpc.prod.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-southeast-1b"

  tags = {
    Name = "prod-private-2"
  }
}

resource "aws_subnet" "prod-private-3" {
  vpc_id                  = aws_vpc.prod.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-southeast-1c"

  tags = {
    Name = "prod-private-3"
  }
}

# Internet GW
resource "aws_internet_gateway" "prod-gw" {
  vpc_id = aws_vpc.prod.id

  tags = {
    Name = "prod"
  }
}

# route tables
resource "aws_route_table" "prod-public" {
  vpc_id = aws_vpc.prod.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod-gw.id
  }

  tags = {
    Name = "prod-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "prod-public-1-a" {
  subnet_id      = aws_subnet.prod-public-1.id
  route_table_id = aws_route_table.prod-public.id
}

resource "aws_route_table_association" "prod-public-2-a" {
  subnet_id      = aws_subnet.prod-public-2.id
  route_table_id = aws_route_table.prod-public.id
}

resource "aws_route_table_association" "prod-public-3-a" {
  subnet_id      = aws_subnet.prod-public-3.id
  route_table_id = aws_route_table.prod-public.id
}

