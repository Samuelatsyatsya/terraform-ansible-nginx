output "web_sg_id" {
  description = "ID of Web Security Group"
  value       = aws_security_group.web_sg.id
}

output "ssh_sg_id" {
  description = "ID of SSH Security Group"
  value       = aws_security_group.ssh_sg.id
}

output "bastion_sg_id" {
  value       = aws_security_group.bastion_sg.id
  description = "Security group ID for bastion host"
}
