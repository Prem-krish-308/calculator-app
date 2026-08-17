resource "aws_ecr_repository" "calculator" {
  name                 = "calculator-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "calculator-app"
  }
}

resource "aws_ecr_lifecycle_policy" "calculator" {
  repository = aws_ecr_repository.calculator.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep only the latest 10 images"

        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 10
        }

        action = {
          type = "expire"
        }
      }
    ]
  })
}