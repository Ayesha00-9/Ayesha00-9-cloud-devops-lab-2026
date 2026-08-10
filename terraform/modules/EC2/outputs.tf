output "bastion_instance_id" {
  description = "ID of the bastion EC2 instance"
  value       = aws_instance.bastion.id
}

output "bastion_public_ip" {
  description = "Public IP of the bastion EC2 instance"
  value       = aws_instance.bastion.public_ip
}

output "app_instance_id" {
  description = "ID of the application EC2 instance"
  value       = aws_instance.app.id
}

output "app_private_ip" {
  description = "Private IP of the application EC2 instance"
  value       = aws_instance.app.private_ip
}