#------------------------------------------------------------
# Preparation for Terraform certification
# High availability server
# @author: Enrique Zetina
# Multiple regions
#------------------------------------------------------------

provider "aws" {
  region = "us-west-1"
}

provider "aws" {
  region = "eu-south-1"
  alias  = "EUROPE"
}

provider "aws" {
  region = "ap-northeast-1"
  alias  = "ASIA"
}

#----------------------------------------------------------
data "aws_ami" "default_latest_ubuntu20" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-*-am64-server-*"]
  }
}

data "aws_ami" "eu_latest_ubuntu20" {
  provider    = aws.EUROPE
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-*-am64-server-*"]
  }
}

data "aws_ami" "ap_latest_ubuntu20" {
  provider    = aws.ASIA
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-*-am64-server-*"]
  }
}
#----------------------------------------------------------

resource "aws_instance" "my_default-server" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.default_latest_ubuntu20.id
  tags = {
    Name = "Defautl server"
  }
}

resource "aws_instance" "eu_default-server" {
  provider      = aws.EUROPE
  instance_type = "t2.micro"
  ami           = data.aws_ami.eu_latest_ubuntu20.id
  tags = {
    Name = "EU server"
  }
}

resource "aws_instance" "ap_default-server" {
  provider      = aws.ASIA
  instance_type = "t2.micro"
  ami           = data.aws_ami.ap_latest_ubuntu20.id
  tags = {
    Name = "ASIA server"
  }
}
