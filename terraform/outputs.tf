output "vpc_id" {
  description = "ID of the deployment VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "deployment_server_id" {
  description = "ID of the deployment EC2 instance"
  value       = aws_instance.deployment_server.id
}

output "deployment_server_public_ip" {
  description = "Public IP address of the deployment server"
  value       = aws_instance.deployment_server.public_ip
}