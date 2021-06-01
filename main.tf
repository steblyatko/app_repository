terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
}

provider "aws" {
    region = "eu-central-1"
}    


resource "aws_instance" "Jenkins" {
    ami = "ami-0e8286b71b81c3cc1"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.my_jenkins.id]
    tags = {
        Name = "Jenkins"
        Owner = "Steblyk Valentyn"
        Project = "Terraform"
    }
}



resource "aws_instance" "WEBplusDB" {
    ami = "ami-0e8286b71b81c3cc1"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.my_webserver.id]
    tags = {
        Name = "WEB and DB Server "
        Owner = "Steblyk Valentyn"
        Project = "Terraform"
    }
}


resource "aws_security_group" "my_webserver" {
  name        = "WEBServer Security Group"
  description = "Security Group for WEB Server"

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Group"
  }
}


resource "aws_security_group" "my_jenkins" {
  name        = "Jenkins Security Group"
  description = "Security Group for Jenkins"

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Group"
  }
}
