output "vpc_id" {
  value = aws_vpc.main.id
}

output "pub_subnets_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}
