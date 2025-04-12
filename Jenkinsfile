pipeline {
    agent {
        docker {
            image 'hashicorp/terraform:1.11.4'
            args '-v $HOME/.aws:/root/.aws'
        }
    }
    environment {
        AWS_REGION = 'eu-west-1'
        AWS_PROFILE='terraform'
        NOTIFICATION_EMAIL = 'your@email.com'  // Replace with your email address
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://your/repo/url/terraform-demo.git'  // Replace with your repository URL
                sh 'chmod +x scripts/setup_prerequisites.sh || true'
            }
        }

        stage('Setup Prerequisites') {
            steps {
                dir('scripts') {
                    sh './setup_prerequisites.sh'
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

        stage('Terraform Apply') {
            steps {
                input 'Approve infrastructure deployment?'
                dir('dev') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
        // Notification actions (comment out to disable)
        success {
            emailext(
                subject: "SUCCESS: ${env.JOB_NAME} [${env.BUILD_NUMBER}]",
                body: """Deployment SUCCESSFUL!
                Job: ${env.JOB_NAME}
                Build: ${env.BUILD_NUMBER}
                Timestamp: ${new Date().format('yyyy-MM-dd HH:mm:ss')}""",
                to: env.NOTIFICATION_EMAIL
            )
        }
        failure {
            emailext(
                subject: "FAILURE: ${env.JOB_NAME} [${env.BUILD_NUMBER}]",
                body: """Deployment FAILED!
                Job: ${env.JOB_NAME}
                Build: ${env.BUILD_NUMBER}
                Timestamp: ${new Date().format('yyyy-MM-dd HH:mm:ss')}""",
                to: env.NOTIFICATION_EMAIL
            )
        }
    }
}
