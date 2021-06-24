#------------------------------------------------------------
# Preparation for Terraform certification
# Build a Webserver with Bootstrap AWS using external files
# @author: Enrique Zetina
#------------------------------------------------------------


provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  # Amazon Linux 2  
  ami                    = "ami-0aeeebd8d2ab47354"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data              = file("user_data.sh")

  tags = {
    Name    = "Webserver build by Terraform"
    Owner   = "Enrique Zetina"
    Project = "Terraform Certification"
  }
}


# Creating a Security group to provide access to our webserver

resource "aws_security_group" "web" {
  name        = "Webserver-SG"
  description = "Security Group for my webserver"

  ingress {
    description = "Ingress rule HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Ingress rule for HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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