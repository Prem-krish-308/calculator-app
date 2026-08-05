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

Install Java and Jenkins on Ubuntu machine
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


