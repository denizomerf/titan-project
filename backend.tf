terraform {
  backend "s3" {
    bucket = "titan-project-deniz-2025"
    key = "global/s3/terraform.tfstate"
    region = "eu-central-1"
    dynamodb_table = "terraform-lock"
    encrypt = true
  }
}