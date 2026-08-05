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
    }
}