
#--------------------
# Terraform certification Lab1
#--------------------

provider "aws" {
#Overwritting  my default region
  region = "us-east-1"
}

resource "aws_instance" "Ubuntu" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  key_name = "terraform-key"

  tags = {
    Name = "Ubuntu-Server"
    Owner = "Enrique Zetina"
    ## Ading additional tags
    Project = "Terraform Certification"
  }
}

# Destroy a resource 
/*
resource "aws_instance" "AWS-Linux" {
  ami           = "ami-0aeeebd8d2ab47354"
  instance_type = "t2.micro"

  tags = {
    Name = "AWS-Server"
    Owner = "ezetina86"
    ## Ading additional tags
    Project = "Terraform Certification"    
  }
 
}
*/