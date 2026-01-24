variable "project" {
  description = "Project name for tags"
  type        = string
  default     = "terraform-ansible"
}

variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}


# List of ingress rules for SSH
variable "ssh_ingress_rules" {
  description = "List of ingress rules for SSH SG"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # override in .tfvars
      description = "SSH"
    }
  ]
}

# List of ingress rules for Web
variable "web_ingress_rules" {
  description = "List of ingress rules for Web SG"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP"
    }
  ]
}

# Egress rules (applies to all SGs)
variable "egress_rules" {
  description = "List of egress rules for all SGs"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "All outbound traffic"
    }
  ]
}

# List of ingress rules for Bastion
variable "bastion_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # default, override in tfvars
      description = "SSH to bastion"
    }
  ]
}
