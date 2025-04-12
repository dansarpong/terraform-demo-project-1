output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app.id
}

output "public_ip" {
  description = "Public IP address of the instance"
  value       = aws_instance.app.public_ip
}

output "private_ip" {
  description = "Private IP address of the instance"
  value       = aws_instance.app.private_ip
}

output "security_group_id" {
  description = "Security group IDs associated with the instance"
  value       = var.security_group_ids
}
