# Calculator Application

A simple calculator built using Flask.

## Features

- Addition
- Subtraction
- Multiplication
- Division
- Automated tests

## Install

```bash
pip install -r requirements.txt
```

## Run

```bash
python app.py
```

Application:

http://127.0.0.1:5000

## Run Tests

```bash
pytest
```

## Install Java and Jenkins on Ubuntu machine
```bash
sudo apt update && sudo apt upgrade -y
```
```bash
sudo apt install openjdk-21-jdk -y
```
```bash
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
```
## Install git, python, pip, docker, sonarscanner
```bash
# Install git
sudo apt install git -y
# Install python
sudo apt install python3 python3-pip python3-venv -y
# Install docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

sudo systemctl enable docker
sudo systemctl start docker

# Allow Jenkins to use Docker
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
groups jenkins

# Install Sonar-Scanner
Configure it on Jenkins

# Install Jfrog CLI
curl -fL https://install-cli.jfrog.io | sh
sudo mv jf /usr/local/bin/
jf --version

```
## Plugins in Jenkins
<img width="666" height="768" alt="image" src="https://github.com/user-attachments/assets/546db37e-c12b-46a9-9964-850f5f0dad31" />
