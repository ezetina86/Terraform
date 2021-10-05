#------------------------------------------------------------
# Preparation for Terraform certification
# High availability server
# @author: Enrique Zetina
# Multiple regions and accounts
#------------------------------------------------------------
provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  region = "us-west-2"
  alias  = "DEV"

  assume_role {
    role_arn = "arn:aws:iam::713872197221:role/TerraformRole"
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "PROD"

  assume_role {
    role_arn = "arn:aws:iam::713872197221:role/TerraformRole"
  }
}

#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#

resource "aws_vpc" "master_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "Master VPC"
  }
}

resource "aws_vpc" "dev_vpc" {
  provider   = aws.DEV
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "Dev VPC"
  }
}

resource "aws_vpc" "prod_vpc" {
  provider   = aws.PROD
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "Prod VPC"
  }
}



