resource "aws_ecr_repository" "api" {
    name = "titan-api"
    image_tag_mutability = "IMMUTABLE"
    image_scanning_configuration {
      scan_on_push = true
    }

    encryption_configuration {
    encryption_type = "AES256"
  }
    tags = {
      Name = "titan-api-repository"
    }

}