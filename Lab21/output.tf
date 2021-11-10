output "user_arn" {
  value = values(aws_iam_user.user)[*].arn
}

output "instaces_ids" {
  value = values(aws_instance.my_server)[*].id
}

output "prod_instace_id" {
  value = aws_instance.my_server["PROD"].id
}

output "instaces_ips" {
  value = values(aws_instance.my_server)[*].public_ip
}

output "prod_instace_ip" {
  value = aws_instance.my_server["PROD"].public_ip
}

output "bastion_public_ip" {
  value = var.create_bastion == "YES" ? aws_instance.bastion_server["bastion"].public_ip : null
}

