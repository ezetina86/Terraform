#------------------------------------------------------------
# Preparation for Terraform certification
# Retrieve Secrets by using secret manager
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
  password             = data.aws_secretsmanager_secret_version.rds_password.secret_string
}

#Generate random password
resource "random_password" "main"{
    length           = 20
    special          = true #Special characters !@#$%^&
    override_special = "#()_"
}

#Create a place to store the  password in Secret Manager (Service not free)
resource "aws_secretsmanager_secret" "rds_password" {
  name                    = "/prod/prod-mysql-rds/password"
  description             = "Master Password for RDS Database"
  recovery_window_in_days = 0
}

#Save the  password in Secret Manager
resource "aws_secretsmanager_secret_version" "rds_password" {
  secret_id     = aws_secretsmanager_secret.rds_password.id
  secret_string = random_password.main.result
}

#Create a place to store a JSON in Secret Manager (Service not free)
resource "aws_secretsmanager_secret" "rds" {
  name                    = "/prod/prod-mysql-rds/all"
  description             = "Master Password for RDS Database"
  recovery_window_in_days = 0
}

#Store JSON
resource "aws_secretsmanager_secret_version" "rds" {
  secret_id     = aws_secretsmanager_secret.rds.id
  secret_string = jsonencode({
      rds_address  = aws_db_instance.prod.address
      rds_port     = aws_db_instance.prod.port
      rds_username = aws_db_instance.prod.username
      rds_password = random_password.main.result
  })
}

#Retrieve the  all
data "aws_secretsmanager_secret_version" "rds"{
    secret_id     = aws_secretsmanager_secret.rds.id
    depends_on    = [aws_secretsmanager_secret_version.rds]
}

#Retrieve the  password
data "aws_secretsmanager_secret_version" "rds_password"{
    secret_id     = aws_secretsmanager_secret.rds_password.id
    depends_on    = [aws_secretsmanager_secret_version.rds_password]
}

#Oputputs
output "rds_password"{
    #not best practice to print in plain text
    value     = random_password.main.result
    sensitive = true
}

output "rds_all"{
    #not best practice to print in plain text
    value     = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)
    sensitive = true
}

output "rds_address"{
    value     = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)["rds_address"]
    sensitive = true
}
output "rds_port"{
    value     = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)["rds_port"]
    sensitive = true
}

output "rds_username"{
    value     = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)["rds_username"]
    sensitive = true
}