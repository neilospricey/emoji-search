pipeline {
    agent any
    stages {
        stage('installDependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('runTests') {
            steps {
                sh 'npm run test-ci'
            }
        }
        stage('buildContainer') {
            steps {
                sh 'docker build -t emoji-search:dev .'
            }
        }                
    }
}