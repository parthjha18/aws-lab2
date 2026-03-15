sudo yum update -y
sudo yum install java-17-amazon-corretto -y
java -version
sudo dnf install -y java-1.8.0-amazon-corretto
sudo yum install java-1.8.0-amazon-corretto-devel -y
sudo yum install maven -y
sudo alternatives --config java
sudo alternatives --config javac
java -version
javac -version
mvn -version
mvn archetype:generate