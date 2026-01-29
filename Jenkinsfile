pipeline {
    agent any

    environment {
        AWS_REGION = "ap-south-1"
        AWS_ACCOUNT_ID = "670339745523"
        REPO_NAME = "spring-web-app"
        IMAGE_TAG = "latest"
        ECR_URL = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
    }

    stages {
        stage('Checkout') {
            steps {
                // Jenkins automatically checks out the code if the job is linked to GitHub
                echo 'Checking out source code...'
            }
        }

        stage('Maven Build') {
            steps {
                // Uses the Maven tool defined in your Global Tool Configuration
                sh 'mvn clean install'
            }
        }

        stage('Docker Build') {
            steps {
                echo "Building Docker image: ${REPO_NAME}..."
                sh "docker build -t ${REPO_NAME} ."
            }
        }

        stage('Push to ECR') {
            steps {
                echo "Logging into Amazon ECR..."
                // Authenticates Docker with AWS ECR
                sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_URL}"

                // Creates repository if missing
                sh "aws ecr create-repository --repository-name ${REPO_NAME} --region ${AWS_REGION} || true"

                echo "Tagging and Pushing..."
                sh "docker tag ${REPO_NAME}:latest ${ECR_URL}/${REPO_NAME}:${IMAGE_TAG}"
                sh "docker push ${ECR_URL}/${REPO_NAME}:${IMAGE_TAG}"
            }
        }
    }

    post {
        always {
            echo "Cleaning up dangling images..."
            // Keeps your AWS disk space clean
            sh "docker image prune -f"
        }
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed. Check logs for details."
        }
    }
}