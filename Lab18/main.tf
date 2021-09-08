#------------------------------------------------------------
# Preparation for Terraform certification
# High availability server
# @author: Enrique Zetina
# Remote commands
#------------------------------------------------------------

provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "myserver" {
  ami                    = "ami-0528712befcd5d885"
  instance_type          = "t2.micro"
  key_name               = "henry-key-west-1"
  vpc_security_group_ids = [aws_security_group.web.id]
  tags = {
    Name  = "My EC2 with remote execution by Terraform"
    Owner = "Enrique Zetina"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/terraform",
      "cd /home/terraform",
      "touch terraform.txt",
      "echo 'Terraform was here...' > terraform.txt"
    ]
    connection {
      type        = "ssh"
      user        = "admin"
      host        = self.public_ip ## Same that aws_instance.my_server_public_ip
      private_key = file("henry-key-west-1.pem")
    }
  }

}




resource "aws_security_group" "web" {
  name = "MySecurityGroup"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all ports"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"

  }
  tags = {
    Name  = "SG by Terraform"
    Owner = "Enrique Zetina"
  }
}
