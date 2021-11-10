#------------------------------------------------------------
# Preparation for Terraform certification
# High availability server
# @author: Enrique Zetina
# Executing local commands
#------------------------------------------------------------

provider "aws" {
  region = "us-west-1"
}

resource "null_resource" "command1" {
  provisioner "local-exec" {
    command = "echo Terraform START: $(date) >> log.txt"
  }
}

resource "null_resource" "command2" {
  provisioner "local-exec" {
    command = "ping -c 5 www.google.com"
  }
}

resource "null_resource" "command3" {
  provisioner "local-exec" {
    interpreter = ["python3", "-c"]
    command     = "print('Helllo World!')"
  }
}

resource "null_resource" "command4" {
  provisioner "local-exec" {
    command = "echo $NAME1 $NAME2 $NAME3 >> log.txt"
    environment = {
      NAME1 = "Enrique"
      NAME2 = "Lili"
      NAME3 = "Leo"
    }
  }
}

resource "aws_instance" "myserver" {
  ami           = "ami-0528712befcd5d885"
  instance_type = "t2.micro"
  provisioner "local-exec" {
    command = "echo ${aws_instance.myserver.private_ip} >> log.txt"
  }
}

resource "null_resource" "command5" {
  provisioner "local-exec" {
    command = "echo terrafom FINISH $(date) >> log.txt"
  }
  depends_on = [
    null_resource.command1,
    null_resource.command2,
    null_resource.command3,
    null_resource.command4,
    aws_instance.myserver
  ]

}
