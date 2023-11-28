output "security_group_id" {
  description = "Outputs the ID of the security group in a list"
  value       = [aws_security_group.app.id]
}
