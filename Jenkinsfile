
pipeline {
    agent any
    
    environment {
        IMAGE_NAME = "gopikrishna1338/currency-exchange-microservice"
        IMAGE_TAG  = "latest"
    }

   
    stages {

        stage('Checkout') {
            steps {
                checkout scm
                sh 'docker --version'
                sh 'mvn --version'
            }
        }

        stage('Unit Tests') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Integration Tests') {
            steps {
                sh 'mvn failsafe:integration-test failsafe:verify'
            }
        }

        stage('Build JAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'dockerid') {
                        sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                    }
                }
            }
        }
    }

    post {
        success {
            echo "✅ Build & Docker Push Successful!"
        }
        failure {
            echo "❌ Build Failed!"
        }
    }
}
