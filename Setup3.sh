sudo apt update -y
sudo apt install -y openjdk-17-jdk
java -version
sudo apt install unzip -y
wget https://services.gradle.org/distributions/gradle-8.5-bin.zip
sudo mkdir -p /opt/gradle
sudo unzip -o -d /opt/gradle gradle-8.5-bin.zip
echo "export PATH=/opt/gradle/gradle-8.5/bin:\$PATH" | sudo tee /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh
gradle -v
mkdir -p my-gradle-project
cd my-gradle-project
gradle init
gradle build
gradle run
gradle test
gradle tasks
gradle dependencies
