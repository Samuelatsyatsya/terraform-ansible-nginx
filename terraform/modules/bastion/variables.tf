variable "project" {
  description = "Project name for tagging"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for bastion host"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for bastion"
  type        = string
}

variable "key_name" {
  description = "SSH key name for bastion"
  type        = string
}

variable "subnet_id" {
  description = "Public subnet ID where bastion will reside"
  type        = string
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the security groups will be created"
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
}

variable "security_group_ids" {
  type = list(string)
}