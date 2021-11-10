output "web_loadbalancer_url" {
  value = aws_elb.web.dns_name
}

output "aws_autoscaling_group" {
  value = aws_autoscaling_group.web.name
}

output "aws_security_group" {
  value = aws_security_group.web.id
}
