pipeline {
    agent {
        node {
            label 'Agent-1'
        }
    }
    environment {
        packageversion = ''
        nexusURL = ':8081'
    }
    options {
        timeout(time: 1 , unit : 'HOURS')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
    parameters {
        string(name: 'version' , defaultvalue: '' , description: 'what is the artifact version?' )
        string(name: 'environment' , defaultvalue: '' , description: 'what is environment?' )
    }
    stages {
        stage('get version') { 
            steps {
                script {
                    def PackageJson = readJSON file: 'package.json'
                    packageversion = PackageJson.version
                    echo "application version: $packageversion"
                } 
            }
        }
        stage('print version') { 
            steps {
                sh """
                  echo "version: ${params.version}"
                  echo "environment: ${params.environment}
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
            steps{
                sh """
                cd terraform 
                terraform apply -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.version}" -auto-approve
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


