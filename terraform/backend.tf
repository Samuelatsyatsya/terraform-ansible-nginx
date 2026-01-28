terraform {
  backend "s3" {
    bucket         = "terraform-ansible-nginx-state"
    key            = "global/terraform.tfstate"
    region         = "eu-central-1"
    use_lockfile = true
    
  }
}
