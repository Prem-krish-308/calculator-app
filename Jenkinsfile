pipeline {

    agent any

   /*environment {
        // Environment variables
    }*/

    stages {

        stage('Checkout') {
            steps {
                echo "Checking out code..."
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'Prem-krish-308', url: 'https://github.com/Prem-krish-308/calculator-app.git']])
            }
        }
        stage('Setup Python Environment')
        {
            steps {
                echo "Creating Python virtual environment..."
                sh 'python -m venv venv'
                echo "Activating virtual environment and installing dependencies..."
                sh 'venv/scripts/activate' 
                echo "Installing dependencies from requirements.txt..."
                sh './venv/bin/pip install -r requirements.txt'
            }
        }
    }
}