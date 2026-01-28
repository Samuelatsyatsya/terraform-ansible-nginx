resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = false

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-app"
      Role = "web"
    }
  )
}
