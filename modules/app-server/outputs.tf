output "ec2_instances_ids" {
  description = "List of IDs of ec2 instances"
  value       = aws_instance.web[*].id
}
