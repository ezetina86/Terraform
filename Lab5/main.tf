#------------------------------------------------------------
# Preparation for Terraform certification
# Using dynamic blocks
# @author: Enrique Zetina
#------------------------------------------------------------


provider "aws" {
  region = "us-east-1"
}

# Creating a Security group to provide access to our webserver

resource "aws_security_group" "web" {
  name        = "Webserver-SG"
  description = "Security Group for my webserver"

  dynamic "ingress" {
    for_each = ["80", "8080", "443", "1000", "8443"]
    content {
      description = "Ingress rule HTTP"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "ingress" {
    for_each = ["80", "8080", "443", "1000", "8443"]
    content {
      description = "Ingress rule HTTP"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }  

  egress {
    description = "Egress rule for all internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name    = "SG build by Terraform"
    Owner   = "Enrique Zetina"
    Project = "Terraform Certification"
  }

}
