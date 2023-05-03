def dockerImage

pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                script {
                    dockerImage = docker.build("boomer12/app:${env.BUILD_NUMBER}")
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
        stage('Deploy') {
            steps {
                script {
                    // Configure kubectl to use your EKS cluster
                    sh 'aws eks update-kubeconfig --region <REGION> --name <CLUSTER_NAME>'
                    
                    // Update the image tag in the deployment.yml file
                    sh "sed -i 's|boomer12/app:.*|boomer12/app:${env.BUILD_NUMBER}|' /path/to/deployment.yml"
                    
                    // Create or update the Kubernetes deployment using the deployment.yml file
                    sh 'kubectl apply -f /path/to/deployment.yml'
                }
            }
        }
    }
}