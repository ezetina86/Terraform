#------------------------------------------------------------
# Preparation for Terraform certification
# High availability server
# @author: Enrique Zetina
# Loops for each
#------------------------------------------------------------

provider "aws" {
  region = "us-west-1"
}

resource "aws_iam_user" "user" {
  for_each = toset(var.aws_users)
  name     = each.value
}


resource "aws_instance" "my_server" {
  for_each      = toset(["DEV", "STAGING", "PROD"])
  ami           = var.ami
  instance_type = var.type
  tags = {
    Name  = "Server-${each.value}"
    Owner = "Enrique Zetina"
  }
}

resource "aws_instance" "server" {
  for_each      = var.server_settings
  ami           = each.value["ami"]
  instance_type = each.value["instance_type"]

  root_block_device {
    volume_size = each.value["root_disksize"]
    encrypted   = each.value["encrypted"]
  }

  volume_tags = {
    Name = "Disk-${each.key}"
  }

  tags = {
    Name = "Server-${each.key}"
  }
}

resource "aws_instance" "bastion_server" {
  for_each         = var.create_bastion == "YES" ? toset(["bastion"]) : []
  ami           = var.ami
  instance_type = var.type
  tags = {
    Name  = "Bastion"
    Owner = "Enrique Zetina"
  }
}
