Step 1: Update System & Install Java

sudo apt update
sudo apt install openjdk-21-jdk -y
java -version

Step 2: Install Maven

wget https://archive.apache.org/dist/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz
sudo tar -xzf apache-maven-3.9.6-bin.tar.gz -C /opt/
echo 'export PATH=/opt/apache-maven-3.9.6/bin:$PATH' | sudo tee /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
mvn -version


Step 3: Install Jenkins

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins -y

Step 4: Start Jenkins

sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins


Step 5: Get Admin Password

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

Step 6: Open Jenkins in Browser
http://<your-ec2-public-ip>:8080

Paste the admin password
Install suggested plugins
Skip or create admin user


Step 7: Install Maven Integration Plugin (UI)

Manage Jenkins → Plugins → Available plugins
Search Maven Integration → check it → Install
Wait for install to complete



Step 8: Configure Maven in Tools (UI)

Manage Jenkins → Tools
Scroll to Maven installations → Add Maven

Name: maven 3.9.6
Uncheck "Install automatically"
MAVEN_HOME: /opt/apache-maven-3.9.6

Save

Step 9: Create Freestyle Job (UI)

Dashboard → New Item
Name: my-app → Freestyle project → OK
Source Code Management → Git

URL: https://github.com/parthjha18/simple-java-maven-app


Build Steps → Add build step → Invoke top-level Maven targets

Maven Version: maven 3.9.6
Goals: clean install


Save → Build Now

Step 10: Find the JAR file
sudo su - jenkins
find /var/lib/jenkins/workspace/my-app -name "*.jar"

Step 11: Run the JAR
java -jar /var/lib/jenkins/workspace/my-app/target/my-app-1.0-SNAPSHOT.jar

Expected output:
Hello World!

Step 15: Fix Built-In Node (Disk Space Issue) — UI

Manage Jenkins → Nodes → Built-In Node → Configure
Set Number of executors: 2
Check "Disk Space Monitoring Thresholds"
Set all 4 threshold fields to: 200mb
Click Save
Click "Bring this node back online"









