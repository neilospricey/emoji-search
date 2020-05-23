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
                sh 'docker build -t emoji-search:$BUILD_NUMBER .; docker tag emoji-search:$BUILD_NUMBER emoji-search:latest'
            }
        }                
        stage('deployToDev') {
            environment {
              STAGE = "Dev"
            }            
            steps {
                sh 'ansible-playbook /opt/ansible/playbooks/dev_server_playbook.yaml'
            }
        } 
        stage('deployToTest') {
            environment {
              STAGE = "Test"
            }            
            steps {
                sh 'ansible-playbook /opt/ansible/playbooks/test_server_playbook.yaml'
            }
        }                        
    }
}