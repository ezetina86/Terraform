variable "number_of_servers" {
  default = 3
}

variable "ami" {
  default = "ami-0528712befcd5d885"
}

variable "type" {
  default = "t2.micro"
}

variable "aws_users" {
  description = "List of users to create"
  default = [
    "enrique_zetina@epam.com",
    "jenzetin@gmail.com",
    "liliet.castro.p@gmail.com"
  ]
}

variable "create_bastion" {
  description = "Provision Baastion Server"
  default     = "NO"
}
