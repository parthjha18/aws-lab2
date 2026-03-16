sudo apt update && sudo apt upgrade -y
sudo apt install openjdk-17-jdk -y
java -version
sudo apt install git -y
git --version
git clone https://github.com/YOUR_USERNAME/simple-java-maven-app.git
wget https://archive.apache.org/dist/maven/maven-3/3.9.2/binaries/apache-maven-3.9.2-bin.tar.gz
sudo tar -xvf apache-maven-3.9.2-bin.tar.gz -C /opt
sudo ln -sfn /opt/apache-maven-3.9.2 /opt/maven
echo 'export PATH=/opt/maven/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
mvn -version
cd simple-java-maven-app
mvn clean package
ls target
cd ..
sudo apt install unzip -y
wget https://services.gradle.org/distributions/gradle-8.5-bin.zip
sudo mkdir -p /opt/gradle
sudo unzip -o -d /opt/gradle gradle-8.5-bin.zip
echo 'export PATH=$PATH:/opt/gradle/gradle-8.5/bin' >> ~/.bashrc
source ~/.bashrc
gradle -v
cd simple-java-maven-app
gradle init
gradle build
java -jar build/libs/my-app-1.0-SNAPSHOT.jar
gradle clean build
java -jar target/*.jar
