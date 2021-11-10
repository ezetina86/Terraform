output "server_id" {
  value = aws_instance.server_test.id
}

output "server_public_ip" {
  value = aws_instance.server_test.public_ip
}
