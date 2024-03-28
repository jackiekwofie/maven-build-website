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
        stage ("upload to nexus") {
            steps {
               nexusArtifactUploader credentialsId: 'nexus-id', groupId: 'com.devops.maven', nexusUrl: '13.60.56.14:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'webapp-snapshot', version: '1.0-SNAPSHOT' 
            }
        }
    }
}