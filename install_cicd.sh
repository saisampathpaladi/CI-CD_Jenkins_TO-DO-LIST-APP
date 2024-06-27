#!/bin/bash

# Update and install Docker and Docker Compose
sudo apt-get update
sudo apt-get install -y docker.io docker-compose

# Add current user to docker group
sudo usermod -aG docker $USER

# Install Java (required for Jenkins)
sudo apt install openjdk-17-jre-headless -y
java --version

# Add Jenkins repository and key
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update

# Install Jenkins
sudo apt-get install -y jenkins

# Start Jenkins service
sudo systemctl start jenkins

# Wait for Jenkins to start
sleep 30

# Check Jenkins service status
systemctl status jenkins

# Retrieve initial admin password
echo "Jenkins initial admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Add Jenkins user to Docker group
sudo usermod -aG docker jenkins

# Reboot to apply group changes (optional, if needed)
echo "Rebooting system to apply group changes..."
sudo reboot

# Post-installation instructions
echo "====================================================="
echo "Jenkins is installed and running."
echo "Please access Jenkins at: http://localhost:8080"
echo "Follow the Jenkins setup wizard to complete the installation."
