pipeline {

    agent any

    stages {

        stage('Checkout') {
            steps {
                echo "Checking out code..."
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'Prem-krish-308', url: 'https://github.com/Prem-krish-308/calculator-app.git']])
            }
        }
        stage('Setup Python Environment'){
            steps {
                echo "Creating Python virtual environment..."
                sh 'python3 -m venv venv'
                echo "Activating virtual environment and installing dependencies..."
                sh './venv/bin/python -m pip install --upgrade pip'
                echo "Installing dependencies from requirements.txt..."
                sh './venv/bin/pip install -r requirements.txt'
                echo "pip list output:"
                sh './venv/bin/pip list'
            }
        }
        stage('Run Tests') {
            steps {
                echo "Running tests..."
                sh './venv/bin/python -m pytest'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                echo "Running SonarQube analysis..."
                script {
                def scannerHome = tool 'sonarqube'

                withSonarQubeEnv('sonarqube') {
                    sh """
                        ${scannerHome}/bin/sonar-scanner
                    """
                    }
                }
            }
        }
    }
}
