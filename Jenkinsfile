pipeline {
    agent any

    tools {
        maven "maven 3.9.6"

    }
    
    environment {
        scannerhome = tool 'sonar'
    }

    stages {

        stage ("Git clone") {
            steps {
                git 'https://github.com/jackiekwofie/maven-build-website.git'
            }
        }

        stage ("Build and Package with Maven") {
            steps {
                sh '''
                mvn clean
                mvn package
                '''
            }
        }

        stage ("Sonarqube Analysis") {
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'sonar-sonar') {  
                    sh "${scannerhome}/bin/sonar-scanner -Dsonar.projectKey=earthapp"
                    }
                }
            }
        }
          stage("Quality Gate") {
            steps {
                    timeout(time: 1, unit: 'HOURS') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }
}
            
         

        
