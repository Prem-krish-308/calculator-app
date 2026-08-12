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
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'

                sh """
                    docker build \
                    -t premkrish308/calculator-app:latest \
                    -t premkrish308/calculator-app:${BUILD_NUMBER} .
                """
            }
        }
        stage('Trivy Image Scan') {
            steps {
                echo 'Scanning Docker image with Trivy...'

                sh """
                    trivy image \
                    --severity HIGH,CRITICAL \
                    --no-progress \
                    premkrish308/calculator-app:${BUILD_NUMBER}
                """
            }
        }
        stage('Push Docker Image') {
            steps {
                echo 'Logging into Docker Hub...'

                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {

                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

                        docker push premkrish308/calculator-app:latest

                        docker push premkrish308/calculator-app:${BUILD_NUMBER}

                        docker logout
                    '''
                }
            }
        }
        stage('Update Helm Image Tag') {
            steps {
                echo "Updating Helm image tag to ${BUILD_NUMBER}..."

                sh '''
                    sed -i 's/^  tag: .*/  tag: "'${BUILD_NUMBER}'"/' calculator-app/values.yaml

                    echo "Updated values.yaml:"
                    cat calculator-app/values.yaml
                '''
            }
        }

        stage('Commit and Push GitOps Changes') {
            steps {
                echo "Committing Helm image tag update..."

                sh '''
                    git config user.name "Jenkins"
                    git config user.email "jenkins@localhost"

                    git add calculator-app/values.yaml

                    git commit \
                        -m "Update calculator image to ${BUILD_NUMBER}" \
                        || echo "No changes to commit"
                '''

                withCredentials([
                    gitUsernamePassword(
                        credentialsId: 'Prem-krish-308',
                        gitToolName: 'Default'
                    )
                ]) {
                    sh '''
                        git push origin main
                    '''
                }
            }
        }
    }
}
