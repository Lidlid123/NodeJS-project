
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                script {
                    def dockerImage = docker.build("boomer12/app:${env.BUILD_NUMBER}")
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
