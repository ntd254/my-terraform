output "security_group_id" {
  value = aws_security_group.main.id
}

output "subnet_id" {
  value = aws_subnet.main.id
}
