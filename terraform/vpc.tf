# Create a VPC to launch our instances into
resource "aws_vpc" "greco_vpc" {
  cidr_block = "172.31.0.0/16"
  tags = "${var.tags}"
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "greco_gateway" {
  vpc_id = "${aws_vpc.greco_vpc.id}"
  tags = "${var.tags}"
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.greco_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.greco_gateway.id}"
}

# Create a subnet to launch our instances into
resource "aws_subnet" "greco_subnet" {
  vpc_id                  = "${aws_vpc.greco_vpc.id}"
  cidr_block              = "172.31.1.0/24"
  map_public_ip_on_launch = true
  tags = "${var.tags}"
}

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "greco_security_group" {
  name        = "greco_open_example"
  description = "defauly greco security group"
  vpc_id      = "${aws_vpc.greco_vpc.id}"
  tags = "${var.tags}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}