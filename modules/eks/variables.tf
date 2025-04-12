variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for EKS nodes"
  type        = list(string)
}

variable "project_name" {
  description = "Project name for cluster naming"
  type        = string
}

variable "instance_type" {
  description = "Worker node instance type"
  type        = string
  default     = "t3.small"
}

variable "disk_size" {
  description = "Disk size for EKS worker nodes"
  type        = number
  default     = 10
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default = "1.32"
}

variable "desired_capacity" {
  description = "Number of worker nodes"
  type        = number
  default     = 1
}

variable "tags" {
  description = "Common tags for resources"
  type        = map(string)
  default     = {}
}

variable "enable_public_access" {
  description = "Enable public API endpoint"
  type        = bool
  default     = true
}
