
variable "type" {
  default = "t2.micro"
}
variable "number_of_servers" {
  default = 4
}

variable "ami" {
  default = "ami-0528712befcd5d885"
}

variable "aws_users" {
  description = "List of users to create"
  default = [
    "enrique_zetina@epam.com",
    "jenzetin@gmail.com",
    "liliet.castro.p@gmail.com"
  ]
}