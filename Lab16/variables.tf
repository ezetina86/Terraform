variable "environment" {
  default = "DEV"
}

variable "project_name" {
  default = "TERRAFORM_PROJECT"
}

variable "owner" {
  default = "Enrique Zetina"
}

variable "tags" {
  default = {
    budget_code = 11223344
    Manager     = "Enrique Zetina"
    Planet      = "Mars"
  }
}
