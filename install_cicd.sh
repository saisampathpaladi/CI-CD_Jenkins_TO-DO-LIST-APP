#!/bin/bash

# Update and install Docker and Docker Compose
sudo apt-get update
sudo apt-get install -y docker.io docker-compose

# Add current user to docker group
sudo usermod -aG docker $USER

# Install Java (required for Jenkins)
sudo apt-get install -y openjdk-17-jre-headless

# Install Jenkins
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install -y jenkins

# Start Jenkins service
sudo systemctl start jenkins

# Wait for Jenkins to start
sleep 30

# Retrieve initial admin password
echo "Jenkins initial admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Add current user to jenkins group
sudo usermod -aG jenkins $USER

# Reboot to apply group changes (optional, if needed)
# sudo reboot

# Post-installation instructions
echo "====================================================="
echo "Jenkins is installed and running."
echo "Please access Jenkins at: http://localhost:8080"
echo "Follow the Jenkins setup wizard to complete the installation."
