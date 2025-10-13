resource "aws_ecr_repository" "api" {
  name                 = "titan-api"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name = "titan-api-repository"
  }

}
