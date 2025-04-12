#!/bin/bash
# Install Docker
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user

# Deploy container
sudo docker run -d -p ${container_port}:${container_port} ${docker_image}

# Enable Docker on reboot
sudo chkconfig docker on
