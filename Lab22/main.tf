#------------------------------------------------------------
# Preparation for Terraform certification
# High availability server
# @author: Enrique Zetina
# Loops for in
#------------------------------------------------------------

provider "aws" {
  region = "us-west-1"
}

resource "aws_iam_user" "user" {
  for_each = toset(var.aws_users)
  name     = each.value
}

resource "aws_instance" "myname" {
  count         = var.number_of_servers
  ami           = var.ami
  instance_type = var.type
  tags = {
    Name = "Server-${count.index + 1}"
  }
}


