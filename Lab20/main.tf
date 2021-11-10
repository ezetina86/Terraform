#------------------------------------------------------------
# Preparation for Terraform certification
# High availability server
# @author: Enrique Zetina
# Loops and counts
#------------------------------------------------------------

provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "my_servers" {
  # Count starts from 0
  count         = var.number_of_servers
  ami           = var.ami
  instance_type = var.type
  tags = {
    Name  = "Server ${count.index + 1}"
    Owner = "Enrique Zetina"
  }
}

resource "aws_iam_user" "user" {
  count = length(var.aws_users)
  name  = element(var.aws_users, count.index)
}

resource "aws_instance" "bastion_server" {
  count         = var.create_bastion == "YES" ? 1 : 0
  ami           = var.ami
  instance_type = var.type
  tags = {
    Name  = "Bastion Server ${count.index + 1}"
    Owner = "Enrique Zetina"
  }
}
