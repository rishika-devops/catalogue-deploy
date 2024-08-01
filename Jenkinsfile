pipeline {
    agent {
        node {
            label 'Agent-1'
        }
    }
    options {
        timeout(time: 1 , unit : 'HOURS')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
    
    parameters {
        string(name: 'version' , defaultValue: '' , description: 'what is the artifact version?' )
        string(name: 'environment' , defaultValue: 'dev' , description: 'what is environment?' )
        booleanParam(name: 'apply' , defaultValue: 'false' , description: 'do u want to apply?' )
        booleanParam(name: 'destroy' , defaultValue: 'false' , description: 'do u want to destroy?' )
    }
    stages {
        stage('print version') { 
            steps {
                sh """
                  echo "version: ${params.version}"
                  echo "environment: ${params.environment}"
                """  
            }
        }
        stage('init') { 
            steps {
                sh """
                  cd terraform
                  terraform init --backend-config=${params.environment}/backend.tf -reconfigure
                """  
            }
        }
        stage('plan'){
            steps{
                sh """
                cd terraform 
                terraform plan -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.version}"
                """
            }
        }
        stage('apply'){
            when{
                expression{
                    params.apply
                }
            }
            steps{
                sh """
                cd terraform 
                terraform apply -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.version}" -auto-approve
                """
            }
        }
        
         stage('Print Credentials') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'nexus-credentials-id', passwordVariable: 'NEXUS_PASSWORD', usernameVariable: 'NEXUS_USERNAME')]) {
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
            
        stage('destroy'){
            when{
                expression{
                    params.destroy
                }
            }
            steps{
                sh """
                cd terraform 
                terraform destroy -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.version}" -auto-approve
                """
            }
        }
    }
    
    post {
        always {
            echo " i will always say hello again"
            deleteDir()
        }
        failure {
            echo " this runs when pipeline is failed , used generally to send some alerts"
        }
        success {
            echo " i will say hello when pipeline is success"
        }
    }
}
}


