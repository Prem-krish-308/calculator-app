provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "Calculator-app"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}
