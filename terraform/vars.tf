variable "profile" {
  default = "default"
}

variable "region" {
  default = "us-east-1"
}

variable "route53zone" {
  default="ZQP6044Z1Y5MJ"
}

variable "route53name" {
  default="grecoec2.tjgreco.com"
}

variable "aws_amis" {
  default = {
    us-east-1 = "ami-4fffc834"
    us-east-2 = "ami-4fffc834"
  }
}

variable "key_name" {
  default = "GRECO_NEW_INSTANCE"
}

variable "vm_user" {
  default = "ec2-user"
}

variable "tags" {
  type = "map"
  default = {
    Name = "greco_example"
  }
}