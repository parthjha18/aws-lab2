Experiment 8: Jenkins CI Pipeline with Ansible Deployment

Step 1: Create 2 EC2 Instances (AWS UI)

Master Machine: Ubuntu
Node Machine: Ubuntu

Step 2: Install Java on Master Machine

sudo apt update
sudo apt install openjdk-21-jdk -y

Step 3: Install Maven on Master Machine

wget https://archive.apache.org/dist/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz
sudo tar -xzf apache-maven-3.9.6-bin.tar.gz -C /opt/
echo 'export PATH=/opt/apache-maven-3.9.6/bin:$PATH' | sudo tee /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
mvn -version


Step 4: Install Ansible on Master Machine
sudo apt install -y ansible
ansible --version

Step 5: Install Jenkins on Master Machine

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
sudo apt-get install fontconfig openjdk-21-jre -y
sudo apt-get install jenkins -y

sudo systemctl start jenkins
sudo systemctl status jenkins


Get admin password:
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

Open port 8080 in Master's Security Group, then open:
http://<master-public-ip>:8080

Step 6: Install Java on Node Machine

sudo apt update
sudo apt install openjdk-21-jdk -y


Step 7: Set Up SSH from Master to Node
On Master machine:

ssh-keygen
cat ~/.ssh/id_ed25519.pub

On Node machine (replace with your actual key):
echo "ssh-ed25519 <master-public-key> ubuntu@<master-private-ip>" >> ~/.ssh/authorized_keys

for master keys--(dont run below  4 lines like they are for understanding)

master-public-key → the output of cat ~/.ssh/id_ed25519.pub on Master machine. It's the long string starting with ssh-ed25519 AAAA...
master-private-ip → visible on AWS EC2 console under your Master instance details. It looks like 172.31.x.x

So the full command becomes something like:
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG8Knk... ubuntu@ip-172-31-37-4" >> ~/.ssh/authorized_keys



Step 8: Copy SSH Keys to Jenkins User (Master Machine)

sudo mkdir -p /var/lib/jenkins/.ssh
sudo cp /home/ubuntu/.ssh/id_ed25519 /var/lib/jenkins/.ssh/
sudo cp /home/ubuntu/.ssh/id_ed25519.pub /var/lib/jenkins/.ssh/
sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh
sudo chmod 700 /var/lib/jenkins/.ssh

Step 9: Create Inventory File (Master Machine)

nano ~/inventory.ini

[webserver]
<node-public-ip> ansible_user=ubuntu ansible_ssh_private_key_file=/var/lib/jenkins/.ssh/id_ed25519 ansible_ssh_common_args='-o StrictHostKeyChecking=no'

Save: Ctrl+O → Enter → Ctrl+X

--> not for execution---
04:59
Node public IP → AWS EC2 console → click on your Node instance → you'll see Public IPv4 address like 51.20.42.192.



Step 10: Create Deploy Playbook (Master Machine)

nano ~/deploy.yml

- name: Deploy Maven JAR to Target Server
  hosts: webserver
  tasks:
    - name: Copy JAR file to Remote Server
      copy:
        src: /var/lib/jenkins/.m2/repository/com/mycompany/app/my-app/1.0-SNAPSHOT/my-app-1.0-SNAPSHOT.jar
        dest: /home/ubuntu/app.jar
        mode: '0755'

    - name: Run Java Application
      shell: nohup java -jar /home/ubuntu/app.jar > app.log 2>&1 &




Save: Ctrl+O → Enter → Ctrl+X


Step 11: Move Files to Jenkins User (Master Machine)

sudo mv ~/deploy.yml ~/inventory.ini /var/lib/jenkins/
sudo chown jenkins:jenkins /var/lib/jenkins/deploy.yml /var/lib/jenkins/inventory.ini
ls /var/lib/jenkins/



Step 12: Configure Jenkins (UI)

Manage Jenkins → Plugins → Install: Maven Integration, Ansible
Manage Jenkins → Tools:

Maven: name maven 3.9.6, path /opt/apache-maven-3.9.6
Ansible: name Ansible, path /usr/bin/


Fix Built-In Node: Manage Jenkins → Nodes → Built-In Node → Configure → executors: 2, all disk thresholds: 200mb


Step-13:

1. Go to Jenkins dashboard → click "New Item"

Enter name: ansible-trial
Select: Freestyle project
Click OK


2. Source Code Management section

Select Git
Repository URL: https://github.com/parthjha18/simple-java-maven-app


3. Scroll down to "Build Steps" section → click "Add build step"
First build step:

Select: Invoke top-level Maven targets
Maven Version: maven 3.9.6
Goals: clean install package

Second build step:

Click "Add build step" again
Select: Execute shell
Command box: ansible-playbook -i /var/lib/jenkins/inventory.ini /var/lib/jenkins/deploy.yml


4. Click Save
5. Click "Build Now" on the left sidebar


Step 14: Verify on Node Machine

java -jar app.jar

Expected output: Hello World!



