provider "aws" {
  region = var.region
  
  default_tags {
    tags = {
      Lab = "terraform-demo-project-1"
    }
  }
}
