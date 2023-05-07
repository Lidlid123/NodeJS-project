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
                    // Update the image tag in the deployment.yml file
                    sh "sed -i 's|boomer12/app:.*|boomer12/app:${env.BUILD_NUMBER}|' myapp.yml"
                    
                    // Create or update the Kubernetes deployment using the deployment.yml file
                    sh 'kubectl apply -f myapp.yml '
                }
            }
        }
        stage('Verify Deployment') {
            steps {
                script {
                    
                    // adding a delay between the deploy phase and the verifcaition phase 
                    sleep 10
                    // Check the load balancer address using curl
                    sh 'curl -f http://a80972bd3401145d08501f980242f9f2-1211242983.us-east-1.elb.amazonaws.com'
                }
            }
        }
    }
    post {
        success {
            slackSend (channel: '#production', message: "Deployment Successful :tada:")
        }
        failure {
            slackSend (channel: '#production', message: "Deployment Failed :x:")
        }
    }
}
