#------------------------------------------------------------
# Preparation for Terraform certification
# Execution with outputs
# @author: Enrique Zetina
#------------------------------------------------------------


provider "aws" {
  region = "us-east-1"
}

#Create 3 EC@ Instances

resource "aws_instance" "web_server" {
  ami                    = "ami-0ab4d1e9cf9a1215a"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.general.id]
  depends_on = [aws_instance.database,
  aws_instance.backend]
  tags = {
    name = "Webserver"
  }
}

resource "aws_instance" "backend" {
  ami                    = "ami-0ab4d1e9cf9a1215a"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.general.id]
  depends_on             = [aws_instance.database]
  tags = {
    name = "Backend"
  }
}

resource "aws_instance" "database" {
  ami                    = "ami-0ab4d1e9cf9a1215a"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.general.id]
  tags = {
    name = "Database"
  }
}

resource "aws_security_group" "general" {
  name = "App Security Group"

  dynamic "ingress" {
    for_each = ["80", "443", "22", "3389"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "My-Security-Group"
  }

}


# Outputs

output "my_security_group"{
  description = "Security Group ID"
  value = aws_security_group.general.id
}

#
#output "my_security_group_all_details"{
#  description = "All details of my Security Group"
#  value = aws_security_group.general
#}
#


/*
output "web_server_private_ip"{
  description = "Web Server Private ID"
  value = aws_instance.web_server.private_ip
}

output "backend_private_ip"{
  description = "Backend Private ID"
  value = aws_instance.backend.private_ip
}


output "database_private_ip"{
  description = "Database Private ID"
  value = aws_instance.database.private_ip
}
*/

output "instances_ids"{
  value = [
    aws_instance.web_server.private_ip,
    aws_instance.backend.private_ip,
    aws_instance.database.private_ip
  ]
}


