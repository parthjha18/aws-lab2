# Update packages
sudo yum update -y

# Install Java 17 (Amazon Corretto)
sudo yum install java-17-amazon-corretto -y

# Verify Java installation
java -version

# Install Java 8 (Amazon Corretto)
sudo dnf install -y java-1.8.0-amazon-corretto

# Install Maven
sudo yum install maven -y

# Verify Maven installation
mvn -version
