provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "custom_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "custom-vpc"
  }
}

resource "aws_subnet" "subnet1" {
  count = 2

  cidr_block = "10.0.${count.index + 1}.0/24"
  vpc_id     = aws_vpc.custom_vpc.id

  tags = {
    Name = "sub1"
  }
}

resource "aws_internet_gateway" "my_Igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_route_table" "my_Route" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_Igw.id
  }

  tags = {
    Name = "example-route-table"
  }
}

resource "aws_route_table_association" "route_association" {
  count = 2

  subnet_id      = aws_subnet.subnet1[count.index].id
  route_table_id = aws_route_table.custom_vpc.id
}
