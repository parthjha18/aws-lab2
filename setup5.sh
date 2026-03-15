#!/bin/bash

echo "==========================================="
echo "JENKINS INSTALLATION EXPERIMENT STARTING"
echo "==========================================="

echo ""
echo "Step 1: Update system and install Java"
sudo apt update
sudo apt install -y default-jre default-jdk
java -version

echo ""
echo "Step 2: Add Jenkins repository key"
sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc 
https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo ""
echo "Step 3: Add Jenkins repository"
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" 
| sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo ""
echo "Step 4: Update package index"
sudo apt-get update

echo ""
echo "Step 5: Install Java 21 runtime required by Jenkins"
sudo apt-get install -y fontconfig openjdk-21-jre

echo ""
echo "Step 6: Install Jenkins"
sudo apt-get install -y jenkins

echo ""
echo "Step 7: Start Jenkins service"
sudo systemctl start jenkins

echo ""
echo "Step 8: Enable Jenkins at startup"
sudo systemctl enable jenkins

echo ""
echo "Step 9: Check Jenkins status"
sudo systemctl status jenkins

echo ""
echo "==========================================="
echo "MANUAL STEPS REQUIRED IN AWS"
echo "==========================================="
echo "1. Go to AWS EC2 Console"
echo "2. Open your Instance"
echo "3. Go to Security Groups"
echo "4. Edit Inbound Rules"
echo "5. Add rule:"
echo "   Type: Custom TCP"
echo "   Port: 8080"
echo "   Source: 0.0.0.0/0"
echo "6. Save rules"
echo ""

echo "==========================================="
echo "ACCESS JENKINS IN BROWSER"
echo "==========================================="
echo "Open browser and go to:"
echo "http://YOUR_PUBLIC_IP:8080"
echo ""

echo "Example:"
echo "http://52.91.222.41:8080"
echo ""

echo "==========================================="
echo "GET JENKINS ADMIN PASSWORD"
echo "==========================================="
echo "Run this command in terminal to get unlock password:"
echo ""

echo "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
echo ""

echo "Copy that password and paste it in Jenkins setup page."

echo ""
echo "==========================================="
echo "FINAL STEPS IN BROWSER"
echo "==========================================="
echo "1. Paste admin password"
echo "2. Click 'Install Suggested Plugins'"
echo "3. Create admin user"
echo "4. Click Save and Continue"
echo "5. Click Save and Finish"
echo "6. Click Start using Jenkins"
echo ""

echo "==========================================="
echo "JENKINS SETUP COMPLETE"
echo "==========================================="
