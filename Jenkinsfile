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
        stage('deployToDev') {
            steps {
                sh 'ansible-playbook /opt/ansible/playbooks/dev_server_playbook.yaml'
            }
        }                
    }
}