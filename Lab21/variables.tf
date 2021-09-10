variable "aws_users" {
  description = "List of IAM users"
  default = [
    "enrique.zetina@myco.com",
    "enrique.moya@myco.com",
    "enrique.castro@myco.com",
    "enrique.peralta@myco.com",
    "enrique.aguilar@myco.com"
  ]
}


variable "ami" {
  default = "ami-0528712befcd5d885"
}

variable "type" {
  default = "t2.micro"
}


variable "server_settings" {
  type        = map(any)
  description = "Setting for servers"
  default = {
    web = {
      ami           = "ami-0528712befcd5d885"
      instance_type = "t2.micro"
      root_disksize = 20
      encrypted     = true
    }
    app = {
      ami           = "ami-0528712befcd5d885"
      instance_type = "t2.micro"
      root_disksize = 10
      encrypted     = false
    }
  }
}


variable "create_bastion" {
  description = "Provision Baastion Server"
  default     = "NO"
}
