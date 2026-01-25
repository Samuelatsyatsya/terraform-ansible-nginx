# Terraform Infrastructure Documentation

## Purpose
This directory contains all Terraform code required to provision AWS infrastructure for the project.

Terraform is responsible for:
- Networking
- Security groups
- EC2 instances
- Bastion host
- SSH key management
- Outputs consumed by Ansible

---

## Modules

### networking
Creates:
- VPC
- Public subnets
- Private subnets
- Internet Gateway
- Route tables and associations

Outputs:
- vpc_id
- public_subnet_ids
- private_subnet_ids

---

### security
Creates:
- Web security group (HTTP access)
- SSH security group
- Bastion security group

Security rules:
- Bastion allows SSH only from your public IP
- Private EC2 allows SSH only from bastion SG
- Web traffic allowed via HTTP

Outputs:
- web_sg_id
- ssh_sg_id
- bastion_sg_id

---

### bastion
Creates:
- Bastion EC2 instance in a public subnet

Inputs:
- VPC ID
- Public subnet ID
- Bastion security group ID
- SSH key name

Outputs:
- bastion_public_ip
- bastion_instance_id

---

### compute
Creates:
- Application EC2 instance in a private subnet

Inputs:
- Private subnet ID
- Web and SSH security group IDs
- SSH key name

Outputs:
- ec2_instance_id
- ec2_private_ip

---

## Variables

Defined in `variables.tf` and populated via `terraform.tfvars`.

Key variables:
- aws_region
- project
- vpc_cidr
- public_subnet_cidrs
- private_subnet_cidrs
- availability_zones
- ami_id
- bastion_ami
- instance_type
- key_name
- my_ip

---

## Applying Terraform

Initialize:
```bash
terraform init
```

Preview changes:
```bash
terraform plan
```


Apply infrastructure:
```bash
terraform apply
```

---

## Outputs

After apply, Terraform outputs values required by Ansible:
- Bastion public IP
- Private EC2 private IP
- SSH key path

Use these values to configure Ansible inventory and SSH ProxyJump.

---

## Security Model

- No direct SSH access to private EC2
- Bastion is the single entry point
- Security groups enforce network boundaries
- SSH access restricted by IP and security group references

---

## Notes

- Any change to your public IP requires updating `my_ip` and re-applying Terraform
- Do not commit private keys or Terraform state files