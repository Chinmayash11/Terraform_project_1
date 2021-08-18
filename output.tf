output "my_console_output" {
  value = aws_instance.my_ec2[*].public_ip

  /* here [*] will show all instances public ip .if u need for single ip then, aws_instance.my_ec2[0].public_ip,
  aws_instance.my_ec2[1].public_ip */

  // or

 // value = [for instance in aws_instance.web : instance.public_ip]

  //sensitive = true
}


output "my_vpc_id" {
  value = data.aws_vpc.ibm.id
}
/*
output "print_the_names" {
  value = [for name in var.user_names : name]

  # this is used when list value
}*/

output "user_with_roles" {
  value = [for name, role in var.iam_users : "${name} is the ${role}"]
}