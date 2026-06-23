Experiment 7: Configuration Management with Ansible

Step 1: Create 2 EC2 Instances (AWS UI)

Master Machine: Ubuntu
Node Machine: Ubuntu

Step 2: Install Ansible on Master Machine

sudo apt update
sudo apt install -y ansible
ansible --version
ansible localhost -m ping

Step 3: Generate SSH Key on Master Machine

ssh-keygen
cat ~/.ssh/id_ed25519.pub

Copy the output.

Step 4: Add Public Key to Node Machine
Run this on Node machine (replace with your actual key):
echo "ssh-ed25519 <your-public-key> ubuntu@<master-private-ip>" >> ~/.ssh/authorized_keys

Step 5: Create Inventory File on Master Machine
nano ~/inventory.ini

Add this (replace with your Node's public IP):
[node_machines]
<node-public-ip> ansible_ssh_user=ubuntu

Save: Ctrl+O → Enter → Ctrl+X

Step 6: Create Playbook on Master Machine

nano ~/install_package.yml

Add this:

---
- name: Install a package on the node machine
  hosts: node_machines
  become: yes

  tasks:
    - name: Update apt cache
      apt:
        update_cache: yes

    - name: Install Nginx
      apt:
        name: nginx
        state: present











Save: Ctrl+O → Enter → Ctrl+X

Step 7: Accept Node's SSH Fingerprint (Master Machine)
ssh ubuntu@<node-public-ip>
Type yes → then  run exit

Step 8: Run the Playbook (Master Machine)
ansible-playbook -i ~/inventory.ini ~/install_package.yml

Step 9: Verify Nginx on Node Machine
ssh ubuntu@<node-public-ip>
systemctl status nginx
exit

Step 10: Allow HTTP in AWS (UI)

Go to Node machine's Security Group
Add inbound rule: HTTP, port 80, 0.0.0.0/0
Save


Step 11: Verify in Browser
http://<node-public-ip>

Expected: Nginx welcome page

Step 12: Stop both instances (AWS UI)




