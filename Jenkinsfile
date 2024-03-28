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
        stage ("Sonarqube analysis") {
            steps {
                 withSonarQubeEnv('sonarqube') {
                    sh 'mvn sonar:sonar'
                 }
            }
        }
        stage ("Quality Gate") {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                     waitForQualityGate abortPipeline: true
                }
            }
        }
            
         

        
        stage ("upload to nexus") {
            steps {
               nexusArtifactUploader artifacts: [[artifactId: 'earth-app', classifier: '', file: '/var/lib/jenkins/workspace/maven-build-website/target/earth-app-1.0-SNAPSHOT.war', type: 'war']], credentialsId: 'nexus-id', groupId: 'com.devops.maven', nexusUrl: '13.60.56.14:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'webapp-snapshot', version: '1.0-SNAPSHOT'
            }
        }
        stage ("Deploy to tomcat") {
            steps {
                deploy adapters: [tomcat9(credentialsId: 'tomcat-credential', path: '', url: 'http://51.20.192.218:8080/')], contextPath: null, war: 'target/*.war'
            }
        }
    }
}