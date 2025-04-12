variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "terraform-demo"
}

variable "region" {
  description = "AWS Region for the project"
  type        = string
  default     = "eu-west-1"
}

variable "docker_image" {
  description = "The Docker image to use for the application server"
  type        = string
  default     = "nginx:1.27.4-alpine"
}

variable "container_port" {
  description = "The port on which the container will listen"
  type        = number
  default     = 80
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "demo-eks"
}
