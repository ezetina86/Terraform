variable "env" {
  default = "test"
}

variable "server_size" {
  default = {
    prod       = "t2.medium"
    staging    = "t2.nano"
    dev        = "t2.small"
    my_default = "t2.micro"
  }
}

variable "ami_id_per_region" {
  description = "My Custom AMI id per Region"
  default = {
    "us-west-1" = "ami-0528712befcd5d885"
    "us-west-2" = "ami-0c7ea5497c02abcaf"
    "us-east-1" = "ami-07d02ee1eeb0c996c"
    "us-east-2" = "ami-089fe97bc00bff7cc"
  }
}

variable "allow_ports" {
  default = {
    prod = ["80", "443"]
    rest = ["80", "443", "8080"]
  }
}
