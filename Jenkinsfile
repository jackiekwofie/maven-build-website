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
    }
}
            
         

        
