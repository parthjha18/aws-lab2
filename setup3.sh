#!/bin/bash

echo "Updating system..."
sudo apt update -y

echo "Installing Java 17..."
sudo apt install -y openjdk-17-jdk

echo "Checking Java version..."
java -version

echo "Installing unzip..."
sudo apt install unzip -y

echo "Downloading Gradle..."
wget https://services.gradle.org/distributions/gradle-8.5-bin.zip

echo "Creating Gradle directory..."
sudo mkdir -p /opt/gradle

echo "Extracting Gradle..."
sudo unzip -o -d /opt/gradle gradle-8.5-bin.zip

echo "Setting Gradle PATH..."
echo "export PATH=/opt/gradle/gradle-8.5/bin:\$PATH" | sudo tee /etc/profile.d/gradle.sh

echo "Applying environment variables..."
source /etc/profile.d/gradle.sh

echo "Checking Gradle version..."
gradle -v

echo "Creating Gradle project folder..."
mkdir -p my-gradle-project
cd my-gradle-project

echo "Starting Gradle project initialization..."
echo "Follow the inputs below when prompted:"
echo ""
echo "Project type: 2 (application)"
echo "Language: 3 (Java)"
echo "Multiple subprojects: no"
echo "Build script DSL: 2 (Groovy)"
echo "Test framework: 4 (JUnit Jupiter)"
echo "Project name: gradle-demo"
echo "Source package: com.myapp"
echo "Java version: press Enter"
echo "New APIs behavior: no"
echo ""

gradle init

echo "Building project..."
gradle build

echo "Running application..."
gradle run

echo "Running tests..."
gradle test

echo "Showing available tasks..."
gradle tasks

echo "Showing dependencies..."
gradle dependencies

echo "Gradle experiment completed!"