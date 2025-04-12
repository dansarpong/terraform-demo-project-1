output "security_group_id" {
  description = "ID of the created security group"
  value       = aws_security_group.main.id
}

output "security_group_name" {
  description = "Name of the created security group"
  value       = aws_security_group.main.name
}
