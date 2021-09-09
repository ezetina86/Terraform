#------------------------------------------------------------
# Preparation for Terraform certification
# High availability server
# @author: Enrique Zetina
# Lookup and Conditions
#------------------------------------------------------------

provider "aws" {
  region = "us-west-1"
}

data "aws_region" "current" {}

resource "aws_instance" "server_test" {
  ami                    = var.ami_id_per_region[data.aws_region.current.name]
  instance_type          = lookup(var.server_size, var.env, var.server_size["my_default"])
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  root_block_device {
    volume_size = 10
    encrypted   = (var.env == "prod") ? true : false
  }

  dynamic "ebs_block_device" {
    for_each = var.env == "prod" ? [true] : []
    content {
      device_name = "/deb/sdb"
      volume_size = 40
      encrypted   = true
    }
  }

  volume_tags = { Name = "Disk-$(var.env)" }
  tags        = { Name = "Server-$(var.env)" }
}

resource "aws_security_group" "my_sg" {
  name = "My Server Security Group"

  dynamic "ingress" {
    for_each = lookup(var.allow_ports, var.env, var.allow_ports["rest"])
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
    Name  = "My Server Dynamic SG"
    Owner = "Enrique Zetina"
  }
}
