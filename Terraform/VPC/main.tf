resource "aws_vpc" "main" {
  cidr_block           = var.vpc-cidr-block
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "publicA" {
  cidr_block        = var.pub-snA-cidr-block
  availability_zone = data.aws_availability_zones.available.names[0]
  vpc_id            = aws_vpc.main.id
  map_public_ip_on_launch = true

}

resource "aws_subnet" "publicB" {
  cidr_block        = var.pub-snB-cidr-block
  availability_zone = data.aws_availability_zones.available.names[1]
  vpc_id            = aws_vpc.main.id
  map_public_ip_on_launch = true
}

resource "aws_subnet" "publicC" {
  cidr_block        = var.pub-snC-cidr-block
  availability_zone = data.aws_availability_zones.available.names[0]
  vpc_id            = aws_vpc.main.id
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "VPC Internet Gateway"
  }

}

resource "aws_route_table" "vpc_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }

  tags = {
    Name = "Route Table for VPC"
  }
}

resource "aws_route_table_association" "pub_subA_rta" {
  subnet_id      = aws_subnet.publicA.id
  route_table_id = aws_route_table.vpc_rt.id
}

resource "aws_route_table_association" "pub_subB_rta" {
  subnet_id      = aws_subnet.publicB.id
  route_table_id = aws_route_table.vpc_rt.id
}

resource "aws_route_table_association" "pub_subC_rta" {
  subnet_id      = aws_subnet.publicC.id
  route_table_id = aws_route_table.vpc_rt.id
}