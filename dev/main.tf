# VPC
module "vpc" {
  source = "../modules/vpc"

  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
}

# App Security Group
module "app_sg" {
  source = "../modules/security-group"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  name_suffix  = "app"

  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  depends_on = [module.vpc]
}

# EC2 Instance
module "app_server" {
  source = "../modules/ec2"

  project_name       = var.project_name
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.app_sg.security_group_id]
  docker_image       = var.docker_image
  container_port     = var.container_port

  depends_on = [module.app_sg]
}

# EKS Cluster
module "eks" {
  source = "../modules/eks"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.public_subnet_ids

  tags = {
    Project = var.project_name
  }

  depends_on = [module.vpc]
}
