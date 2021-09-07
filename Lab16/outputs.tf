output "vpc_ip" {
  value = aws_vpc.main.id
}

output "public_ip" {
  value = aws_eip.my_static_ip.public_ip
}
