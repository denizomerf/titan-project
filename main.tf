provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "tfstate" {
  bucket = "titan-project-deniz-2025"

  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
  
}

resource "aws_s3_bucket_versioning" "tfstate_versioning" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
  
}

resource "aws_dynamodb_table" "terraform_lock" {  # State locking table 
  name         = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}