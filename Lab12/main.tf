#------------------------------------------------------------
# Preparation for Terraform certification
# Fetch latest AMI ID
# @author: Enrique Zetina
#------------------------------------------------------------

provider "aws" {
  region = "us-east-1"
}

/*
resource "aws_instance" "my-server" {
    ami = data.aws_linux2.id
    instance_type = "t2.micro"
  
}
*/

data "aws_ami" "ubuntu_server"{
    owners = [ "099720109477" ]
    most_recent = true
    filter{
        name = "name"
        values= ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
}

data "aws_ami" "aws_linux2"{
    owners = [ "137112412989" ]
    most_recent = true
    filter{
        name = "name"
        values= ["amzn2-ami-hvm-*"]
    }
}

data "aws_ami" "windows_server"{
    owners = [ "801119661308" ]
    most_recent = true
    filter{
        name = "name"
        values = ["Windows_Server-2019-English-Full-Base-*"]
    }
}


output "ubuntu_server_ami_id" {
  value = data.aws_ami.ubuntu_server.id
}

output "aws_linux2r_ami_id" {
  value = data.aws_ami.aws_linux2.id
}

output "windows_server_ami_id" {
  value = data.aws_ami.windows_server.id
}