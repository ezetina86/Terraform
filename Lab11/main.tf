#------------------------------------------------------------
# Preparation for Terraform certification
# Datasources information
# @author: Enrique Zetina
#------------------------------------------------------------

provider "aws" {

}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "working" {}

data "aws_vpcs" "vpcs" {}

output "region_name" {
  value = data.aws_region.current.name
}

output "region_description" {
  value = data.aws_region.current.description
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "availability_zones" {
  value = data.aws_availability_zones.working.names
}

output "aws_vpcs" {
  value = data.aws_vpcs.vpcs.ids
}
