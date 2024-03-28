pipeline {
    agent any 

    tools {
        maven "maven 3.9.6"
    }

    stages {
        stage ("Git clone") {
            steps {
                git 'https://github.com/jackiekwofie/maven-build-website.git'
            }
        }
        stage ("Build with maven") {
            steps {
                sh'''
                mvn clean
                mvn test
                mvn package
                '''

            }
        }
          stage('SonarQube Analysis') {
            environment {
                ScannerHome = tool 'sonar5.0'
            }
            steps {
                script {
                    withSonarQubeEnv('sonarqube') {
                        sh "${ScannerHome}/bin/sonar-scanner -Dsonar.projectKey=jomacs"
                    }
                }
            }
        }
    }
}