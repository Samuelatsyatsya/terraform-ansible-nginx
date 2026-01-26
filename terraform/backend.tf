terraform {
  backend "s3" {
    bucket         = "terraform-ansible-nginx-state"
    key            = "global/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-ansible-nginx-locks"
    encrypt        = true
  }
}
