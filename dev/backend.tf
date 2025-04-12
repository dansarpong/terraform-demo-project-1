# S3 backend configuration
terraform {
  backend "s3" {
    bucket         = "terraform-demo-state-bucket"
    key            = "dev/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-demo-state-lock"
    encrypt        = true
  }
}
