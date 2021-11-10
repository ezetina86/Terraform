output "instance_ids" {
  value = aws_instance.my_servers[*].id
}

output "instamce_public_ips" {
  value = aws_instance.my_servers[*].public_ip
}

output "iam_users_arn" {
  value = aws_iam_user.user[*].name
}

output "bastion_public_ip" {
  value = var.create_bastion == "YES" ? aws_instance.bastion_server[0].public_ip : null
}
