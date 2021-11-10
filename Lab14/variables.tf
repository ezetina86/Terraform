variable "aws_region" {
  description = "Region were the infrastructure will be deployed"
  type        = string //number of bool
  default     = "us-west-2"
}

variable "port_list" {
  description = "List of ports to open"
  type        = list(any)
  default     = ["80", "443"]
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "tags" {
    description = "Tags to apply to the resources"
    type = map(any)
    default = {
      Owner = "Enrique Zetina"
      Environment = "Development"
      Project = "Terraform certification" 
    }
  
}