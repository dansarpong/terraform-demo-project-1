variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
}

variable "name_suffix" {
  description = "Suffix for security group name"
  type        = string
  default     = "sg"
}

variable "description" {
  description = "Security group description"
  type        = string
  default     = null
}

variable "ingress_rules" {
  description = "List of ingress rules for the security group"
  type = list(object({
    description              = optional(string, null)
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = optional(list(string), [])
    source_security_group_id = optional(string, null)
    self                     = optional(bool, false)
  }))
}

variable "egress_rules" {
  description = "List of egress rules for the security group"
  type = list(object({
    description              = optional(string, null)
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = optional(list(string), [])
    source_security_group_id = optional(string, null)
  }))
  default = []
}

variable "tags" {
  description = "Additional tags for the security group"
  type        = map(string)
  default     = {}
}
