pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                // Checkout source code
                checkout scm
            }
        }

        stage('Print Credentials and Download Artifact') {
            steps {
                script {
                    // Use Jenkins credentials plugin to provide username and password
                    withCredentials([usernamePassword(credentialsId: 'nexus-auth', passwordVariable: 'NEXUS_PASSWORD', usernameVariable: 'NEXUS_USERNAME')]) {
                        // Debugging: Print credentials to the console (not recommended for production)
                        echo "Nexus Username: ${env.NEXUS_USERNAME}"
                        echo "Nexus Password: ${env.NEXUS_PASSWORD}"
                        
                        // Securely download the artifact
                        sh """
                        curl -u $NEXUS_USERNAME:$NEXUS_PASSWORD -O http://35.168.18.196:8081/repository/catalogue/com/roboshop/catalogue/2.0.0/catalogue-2.0.0.zip
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            echo "Build complete!"
        }
        success {
            echo "Build succeeded!"
        }
        failure {
            echo "Build failed!"
        }
    }
}
