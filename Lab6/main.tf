#------------------------------------------------------------
# Preparation for Terraform certification
# Build a Webserver with Bootstrap AWS using external teamplate
# Zero Downtime server
# @author: Enrique Zetina
#------------------------------------------------------------


provider "aws" {
  region = "us-east-1"
}

#Adding elastic IP
resource "aws_eip" "web" {
  instance = aws_instance.web.id
  tags = {
    Name    = "Static Ip for Webserver"
    Owner   = "Enrique Zetina"
    Project = "Terraform Certification"
  }
}

resource "aws_instance" "web" {
  # Amazon Linux 2  
  ami                    = "ami-0aeeebd8d2ab47354"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data              = file("user_data.sh")

  #Add almost zero downtime
  lifecycle {
    create_before_destroy = true
  }

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

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      description = "Ingress rule HTTP and HTTPS"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
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
