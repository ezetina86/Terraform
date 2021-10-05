#------------------------------------------------------------
# Preparation for Terraform certification
# High availability server
# @author: Enrique Zetina
# Remote State Layer 2 Web
#------------------------------------------------------------

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "ez-it-terraform-remote-state" //buckett to save
    key    = "dev/web/terraform.tfstate"    //object to save
    region = "us-west-1"                    //region of the bucket
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "ez-it-terraform-remote-state"  
    key    = "dev/network/terraform.tfstate"
    region = "us-west-1"
  }
}

resource "aws_instance" "webserver" {
  ami           = "ami-0aeeebd8d2ab47354"
  instance_type = var.instance_type
  subnet_id     = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]
  user_data     = file("user_data.sh")
  tags = {
    "Name"  = "${var.env}-WebServer"
    "Owner" = "Enrique Zetina"
  }
}

resource "aws_security_group" "webserver" {
  name = "WebServer Security Gruoup"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress  {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress  {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress  {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name"  = "${var.env}-WebServer-sg"
    "Owner" = "Enrique Zetina"
  }
}
