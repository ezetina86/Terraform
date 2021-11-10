#------------------------------------------------------------
# Preparation for Terraform certification
# High availability server
# @author: Enrique Zetina
# Variables with auto filling
#------------------------------------------------------------

provider "aws" {
#Overwritting  my default region
  region = "us-east-1"
}

resource "aws_instance" "Ubuntu" {
  ami           = var.ami
  instance_type =  var.instance_type
  key_name = "terraform-key"

  tags = {
    Name = "Ubuntu-Server"
    Owner = "Enrique Zetina"
    ## Ading additional tags
    Project = "Terraform Certification"
  }
}