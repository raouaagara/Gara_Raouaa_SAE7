pipeline {
    agent any

    tools {
        maven 'M3'  
        jdk 'JAVA_HOME'  
    }

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub-creds' 
        IMAGE_NAME = 'raouaaa/student-management'
        IMAGE_TAG = '1.0'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning repository...'
                git branch: 'Devops', url: 'https://github.com/raouaagara/Gara_Raouaa_SAE7.git'
            }
        }

        stage('Build Maven') {
            steps {
                echo 'Building project with Maven...'
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh "docker build -t $IMAGE_NAME:$IMAGE_TAG ."
            }
        }

        stage('Push Docker Image') {
            steps {
                echo 'Pushing Docker image to DockerHub...'
                withCredentials([usernamePassword(credentialsId: "$DOCKERHUB_CREDENTIALS", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh "docker push $IMAGE_NAME:$IMAGE_TAG"
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline terminé avec succès !'
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
        }
        failure {
            echo 'La pipeline a échoué.'
        }
    }
}
