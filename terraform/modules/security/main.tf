# Web Security Group
resource "aws_security_group" "web_sg" {
  name        = "${var.project}-web-sg"
  description = "Web Security Group"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.web_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
      description = egress.value.description
    }
  }

  tags = {
    Project = var.project
    Type    = "web"
  }
}

# SSH Security Group
resource "aws_security_group" "ssh_sg" {
  name        = "${var.project}-ssh-sg"
  description = "SSH Security Group"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ssh_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
      description = egress.value.description
    }
  }

  tags = {
    Project = var.project
    Type    = "ssh"
  }
}


# Bastion Security Group
resource "aws_security_group" "bastion_sg" {
  name        = "${var.project}-bastion-sg"
  description = "Bastion Security Group"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.bastion_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
      description = egress.value.description
    }
  }

  tags = {
    Project = var.project
    Type    = "bastion"
  }
}
