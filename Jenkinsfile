pipeline {
    agent any
    stages {
        stage('install') {
            steps {
                sh 'npm install'
            }
        },
        stage('test') {
            steps {
                sh 'npm run test'
            }
        },
        stage('build') {
            steps {
                sh 'npm run build'
            }
        }                
    }
}