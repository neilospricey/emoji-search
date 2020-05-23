pipeline {
    environment {
        CI = 'true'
    }
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
            when {
                branch 'master' 
            }            
            environment {
              STAGE = "Dev"
            }            
            steps {
                sh 'ansible-playbook /opt/ansible/playbooks/dev_server_playbook.yaml'
            }
        }                       
    }
}