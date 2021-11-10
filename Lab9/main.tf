#------------------------------------------------------------
# Preparation for Terraform certification
# Retrieve Secrets
# @author: Enrique Zetina
#------------------------------------------------------------


provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "prod" {
  identifier           = "prod-mysql-rds"
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  apply_immediately    = true 
  username             = "foo"
  password             = data.aws_ssm_parameter.rds_password.value
}

#Generate random password
resource "random_password" "main"{
    length           = 20
    special          = true #Special characters !@#$%^&
    override_special = "#()_"
}

#Store password
resource "aws_ssm_parameter" "rds_password"{
    name        = "/prod/prod-mysql-rds/password"
    description = "Master Password for RDS Database"
    type        = "SecureString"
    value       = random_password.main.result
}

#Retrieve password
data "aws_ssm_parameter" "rds_password"{
    name        = "/prod/prod-mysql-rds/password" 
    depends_on  = [aws_ssm_parameter.rds_password]
}

#Oputputs
output "rds_address"{
    value = aws_db_instance.prod.address
}

output "rds_port"{
    value = aws_db_instance.prod.port
}

output "rds_username"{
    value = aws_db_instance.prod.username
}

output "rds_password"{
    #not best practice to print in plain text
    value     = data.aws_ssm_parameter.rds_password.value
    sensitive = true
}