output "vpc_id" {
  value = module.networking.vpc_id
}

output "private_subnet_ids" {
  value = module.networking.private_subnet_ids
}

output "ec2_private_ip" {
  value = module.compute.private_ip
}

output "ec2_instance_id" {
  value = module.compute.instance_id
}

output "ssh_key_path" {
  value     = module.compute.ssh_key_path
  sensitive = true
}

output "bastion_instance_id" {
  value = module.bastion.bastion_instance_id
}

output "bastion_public_ip" {
  value = module.bastion.bastion_public_ip
}

output "bastion_public_dns" {
  value = module.bastion.bastion_public_dns
}

output "bastion_private_ip" {
  value = module.bastion.bastion_private_ip
}
