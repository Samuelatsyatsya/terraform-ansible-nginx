# Terraform Backend Configuration
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-ansible-nginx-state"

  tags = {
    Project = "terraform-ansible-nginx"
  }
}

# Enable versioning
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enforce server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


#State Locking Table
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-ansible-nginx-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Project = "terraform-ansible-nginx"
  }
}
