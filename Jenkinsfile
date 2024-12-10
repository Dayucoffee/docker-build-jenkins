pipeline {
    agent any
environment {
        DOCKER_IMAGE = 'wildechild/custom-nginx'
        DOCKER_TAG = 'v1.0'
    }
    stages {
        stage('Checkout') {
            steps {
                // Checkout the latest code from your Git repository
                git 'https://github.com/Dayucoffee/docker-build-jenkins.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image with a custom Nginx page
                    sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    // Log in to Docker Hub
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', 
                      usernameVariable: 'DOCKER_USER', 
                      passwordVariable: 'DOCKER_PASS')]) {
                        sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    }
                    // Push the Docker image to Docker Hub
                    sh 'docker push $DOCKER_IMAGE:$DOCKER_TAG'
                }
            }
        }
        stage('Clean Up') {
            steps {
                script {
                    // Clean up local Docker images to save space
                    sh 'docker rmi $DOCKER_IMAGE:$DOCKER_TAG || true'
                }
            }
        }
    }
    post {
        success {
            echo 'Custom Nginx Docker image built and pushed successfully!'
        }
        failure {
            echo 'Build or push failed. Please check the logs.'
        }
    }
}