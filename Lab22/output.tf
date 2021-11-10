output "insrance_ids" {
  value = aws_instance.myname[*].id
}

output "instance_publics_ips" {
  value = aws_instance.myname[*].public_ip
}

output "server_id_ip" {
  value = [
    for x in aws_instance.myname :
    "Server with ID ${x.id} has public IP: ${x.public_ip}"
  ]
}


output "server_id_ip_map" {
  value = {
    for x in aws_instance.myname :
    x.id => x.public_ip
  }

}

output "users_all" {
  value = [
      for user in aws_iam_user.user:
      "User ID is ${user.id} has ARN ${user.arn}"
  ]
}

output "users_unique_id" {
  value = {
      for user in aws_iam_user.user:
      user.unique_id => user.name
  }
}

output "users_unique_id_custom" {
  value = {
      for user in aws_iam_user.user:
      user.unique_id => user.name
      if length(user.name) < 7
  }
}