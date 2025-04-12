# EC2 Instance with Docker Deployment
resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type           = var.instance_type
  subnet_id               = var.subnet_id
  vpc_security_group_ids  = var.security_group_ids

  # User data for Docker installation and container deployment
  user_data = templatefile("${path.module}/user_data.tpl", {
    docker_image    = var.docker_image
    container_port  = var.container_port
  })

  tags = {
    Name = "${var.project_name}-app"
  }
}
