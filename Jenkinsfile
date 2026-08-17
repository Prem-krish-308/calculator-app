pipeline {

    agent any

    environment {
        AWS_REGION = 'ap-southeast-2'
        ECR_REPOSITORY = '306372151512.dkr.ecr.ap-southeast-2.amazonaws.com/calculator-app'
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Checking out code..."

                checkout scmGit(
                    branches: [[name: '*/main']],
                    extensions: [],
                    userRemoteConfigs: [[
                        credentialsId: 'Prem-krish-308',
                        url: 'https://github.com/Prem-krish-308/calculator-app.git'
                    ]]
                )
            }
        }

        stage('Setup Python Environment') {
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

        /*stage('SonarQube Analysis') {
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
        }*/

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."

                sh """
                    docker build \
                    -t ${ECR_REPOSITORY}:latest \
                    -t ${ECR_REPOSITORY}:${BUILD_NUMBER} .
                """
            }
        }

        stage('Trivy Image Scan') {
            steps {
                echo "Scanning Docker image with Trivy..."

                sh """
                    trivy image \
                    --severity HIGH,CRITICAL \
                    --no-progress \
                    ${ECR_REPOSITORY}:${BUILD_NUMBER}
                """
            }
        }

        stage('Push Image to ECR') {
            steps {
                echo "Logging into AWS ECR..."

                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws-ecr-credentials']
                ]) {

                    sh '''
                        aws ecr get-login-password \
                            --region "$AWS_REGION" | \
                        docker login \
                            --username AWS \
                            --password-stdin "$ECR_REPOSITORY"

                        echo "Pushing image to ECR..."

                        docker push "$ECR_REPOSITORY:latest"

                        docker push "$ECR_REPOSITORY:${BUILD_NUMBER}"

                        echo "Logging out from ECR..."

                        docker logout "$ECR_REPOSITORY"
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
                        credentialsId: 'github-pat-cred',
                        gitToolName: 'Default'
                    )
                ]) {
                    sh '''
                        git push origin HEAD:main
                    '''
                }
            }
        }
    }
}