# EKS Cluster configuration
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name                   = "${var.project_name}-eks"
  cluster_version                = var.kubernetes_version
  cluster_endpoint_public_access = var.enable_public_access

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  cloudwatch_log_group_retention_in_days   = 7
  enable_cluster_creator_admin_permissions = true

  # EKS Addons
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  # EKS Managed Node Group
  eks_managed_node_groups = {
    "${var.project_name}" = {
      ami_type       = "AL2_x86_64"
      instance_types = [var.instance_type]
      disk_size      = var.disk_size

      min_size     = var.desired_capacity
      max_size     = var.desired_capacity + 1
      desired_size = var.desired_capacity
    }
  }

  tags = var.tags
}
