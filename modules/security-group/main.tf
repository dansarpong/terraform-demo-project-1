# Main security group resource
resource "aws_security_group" "main" {
  name        = "${var.project_name}-${var.name_suffix}"
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge(
    {
      "Name" = "${var.project_name}-${var.name_suffix}"
    },
    var.tags
  )
}

# Ingress Rules
resource "aws_security_group_rule" "ingress" {
  for_each = zipmap([for i, rule in var.ingress_rules : i], var.ingress_rules)

  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  security_group_id = aws_security_group.main.id
  cidr_blocks       = each.value.cidr_blocks

  lifecycle {
    create_before_destroy = true
  }
}

# Egress Rules
resource "aws_security_group_rule" "egress" {
  for_each = zipmap([for i, rule in var.egress_rules : i], var.egress_rules)

  type              = "egress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  security_group_id = aws_security_group.main.id
  cidr_blocks       = each.value.cidr_blocks

  lifecycle {
    create_before_destroy = true
  }
}
