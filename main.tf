terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
        Name = "TF VPC"
    }
}

resource "aws_subnet" "mysubneta" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "TF Subnet-A"
  }
}

resource "aws_subnet" "mysubnetb" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "TF Subnet-B"
  }
}

resource "aws_instance" "myec2a" {
    subnet_id = aws_subnet.mysubneta.id
    ami = "ami-01cc34ab2709337aa"
    instance_type = "t2.micro"

    tags = {
        Name = "TF EC2-A"
    }
}

resource "aws_instance" "myec2b" {
    subnet_id = aws_subnet.mysubnetb.id
    ami = "ami-01cc34ab2709337aa"
    instance_type = "t2.micro"

    tags = {
        Name = "TF EC2-B"
    }
}