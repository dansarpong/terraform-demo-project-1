pipeline {
    agent {
        docker {
            image 'hashicorp/terraform:1.11.4'
            args "--entrypoint=''"
        }
    }
    environment {
        NOTIFICATION_EMAIL = 'hyhapi@cyclelove.cc'  // Replace with your email address
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
