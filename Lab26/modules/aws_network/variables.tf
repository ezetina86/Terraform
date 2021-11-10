variable "env" {
  default = "Dev"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"

}


variable "private_subnet_cidr" {
  default = [
    "10.0.11.0/24",
    "10.0.22.0/24"
  ]
}


variable "public_subnet_cidr" {
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "tags" {
  default = {
    Owner   = "Enrique Zetina"
    Project = "Michel Angelo"
  }
}
