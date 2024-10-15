resource "aws_vpc" "task2-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc-task2"
  }
}

resource "aws_subnet" "task2-amazon-linux-subnet" {
  vpc_id                  = aws_vpc.task2-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-amazon-linux-task2"
  }
}

resource "aws_subnet" "task2-ubuntu-subnet" {
  vpc_id                  = aws_vpc.task2-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-ubuntu-task2"
  }
}

resource "aws_internet_gateway" "task2-igw" {
  vpc_id = aws_vpc.task2-vpc.id

  tags = {
    Name = "igw-task2"
  }
}

resource "aws_route_table" "task2-ubuntu-rt" {
  vpc_id = aws_vpc.task2-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.task2-igw.id
  }

  tags = {
    Name = "rt-ubuntu-task2"
  }
}

resource "aws_route_table" "task2-amazon-linux-rt" {
  vpc_id = aws_vpc.task2-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.task2-igw.id
  }

  tags = {
    Name = "rt-amazon-linux-task2"
  }
}

resource "aws_route_table_association" "rt-ubuntu-associations" {
  subnet_id      = aws_subnet.task2-ubuntu-subnet.id
  route_table_id = aws_route_table.task2-ubuntu-rt.id
}

resource "aws_route_table_association" "rt-amazon-linux-associations" {
  subnet_id      = aws_subnet.task2-amazon-linux-subnet.id
  route_table_id = aws_route_table.task2-amazon-linux-rt.id
}
