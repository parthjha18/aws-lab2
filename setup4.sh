#!/bin/bash

echo "==========================================="
echo "MAVEN TO GRADLE EXPERIMENT SETUP STARTING"
echo "==========================================="

echo ""
echo "Step 1: Install Java"
sudo apt update && sudo apt upgrade -y
sudo apt install openjdk-17-jdk -y
java -version

echo ""
echo "Step 2: Install Git"
sudo apt install git -y
git --version

echo ""
echo "IMPORTANT:"
echo "Before running this script, fork the repository below into your GitHub:"
echo "https://github.com/jenkins-docs/simple-java-maven-app"
echo ""

echo "Cloning your forked repository..."
echo "Edit the repo URL below if needed."
git clone https://github.com/YOUR_USERNAME/simple-java-maven-app.git

echo ""
echo "Step 3: Install Maven"
wget https://archive.apache.org/dist/maven/maven-3/3.9.2/binaries/apache-maven-3.9.2-bin.tar.gz
sudo tar -xvf apache-maven-3.9.2-bin.tar.gz -C /opt
sudo ln -sfn /opt/apache-maven-3.9.2 /opt/maven
echo 'export PATH=/opt/maven/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
mvn -version

echo ""
echo "Step 4: Build project using Maven"
cd simple-java-maven-app
mvn clean package

echo ""
echo "Checking Maven build output (target folder)"
ls target

echo ""
echo "Step 5: Install Gradle"
cd ..
sudo apt install unzip -y
wget https://services.gradle.org/distributions/gradle-8.5-bin.zip
sudo mkdir -p /opt/gradle
sudo unzip -o -d /opt/gradle gradle-8.5-bin.zip
echo 'export PATH=$PATH:/opt/gradle/gradle-8.5/bin' >> ~/.bashrc
source ~/.bashrc
gradle -v

echo ""
echo "==========================================="
echo "Step 6: Gradle Initialization Starting"
echo "When prompted choose the following:"
echo ""
echo "Generate Gradle build from Maven? -> yes"
echo ""
echo "Select build script DSL:"
echo "1: Kotlin"
echo "2: Groovy"
echo "Enter selection -> 2"
echo ""
echo "Generate build using new APIs? -> no"
echo "==========================================="
echo ""

cd simple-java-maven-app
gradle init

echo ""
echo "Now edit build.gradle and ADD the following lines:"
echo ""

echo "id 'application'"
echo ""
echo "jar {"
echo "    manifest {"
echo "        attributes("
echo "            'Main-Class': 'com.mycompany.app.App'"
echo "        )"
echo "    }"
echo "}"
echo ""

echo "Press ENTER after editing build.gradle to continue..."
read

echo ""
echo "Step 7: Build project using Gradle"
gradle build

echo ""
echo "Step 8: Run Gradle build output"
java -jar build/libs/my-app-1.0-SNAPSHOT.jar

echo ""
echo "Step 9: Clean and rebuild using Gradle"
gradle clean build

echo ""
echo "Step 10: Run Maven build output"
java -jar target/*.jar

echo ""
echo "==========================================="
echo "EXPERIMENT COMPLETED SUCCESSFULLY"
echo "Both Maven and Gradle builds should print:"
echo "Hello World!"
echo "==========================================="
