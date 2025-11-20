pipeline {
    agent any

    tools {
        maven 'MAVEN_HOME'  
    }

    stages {
        stage('Checkout depuis GitHub') {
            steps {
                git branch: 'main', url: 'https://github.com/raouaagara/Gara_Raouaa_SAE7.git'
            }
        }

        stage('Build (clean & package)') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
    }

    post {
        success {
            echo "✔️ Build terminé — livrable disponible dans /target/"
        }
        failure {
            echo "❌ Erreur — vérifie les logs"
        }
    }
}
