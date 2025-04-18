pipeline {
    agent {
        docker {
            image 'hashicorp/terraform:1.11.4'
            args "--entrypoint=''"
        }
    }
    stages {
        stage('Set AWS Credentials') {
            steps {
                script {
                    withCredentials([usernamePassword(
                        credentialsId: 'aws-credentials',
                        usernameVariable: 'ACCESS_KEY',
                        passwordVariable: 'SECRET_KEY'
                    )]) {
                        env.AWS_ACCESS_KEY_ID = ACCESS_KEY
                        env.AWS_SECRET_ACCESS_KEY = SECRET_KEY
                    }
                }
            }
        }
        stage('Terraform Init') {
            steps {
                dir('dev') {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                dir('dev') {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                input 'Approve infrastructure deployment?'
                dir('dev') {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }
    post {
        // Clean up workspace after build (optional, uncomment to enable)
        // always {
        //     cleanWs()
        // }
        // Notify Slack on build status (optional, uncomment to enable)
        // success {
        //     slackSend channel: '#devops',
        //             color: 'good',
        //             message: "Deployment SUCCESSFUL: ${env.JOB_NAME} [${env.BUILD_NUMBER}]"
        // }
        // failure {
        //     slackSend channel: '#devops',
        //             color: 'danger',
        //             message: "Deployment FAILED: ${env.JOB_NAME} [${env.BUILD_NUMBER}]"
        // }
    }
}
