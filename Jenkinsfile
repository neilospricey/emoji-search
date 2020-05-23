pipeline {
    agent any
    environment {
        CI = 'true'
    }
    stages {
        stage('installDependencies') {
            steps {
                sh 'npm installs'
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
     post {  
         failure {  
             mail bcc: '', body: "<b>Example</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL of the build: ${env.BUILD_URL} <br> ${env.GIT_COMMIT} <br> ${env.GIT_COMMITTER_NAME} <br> ${env.GIT_COMMITTER_EMAIL} <br> ${env.GIT_URL} <br> ${env.GIT_BRANCH} <br> ${env.GIT_COMMIT}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "ERROR CI: Project name -> ${env.JOB_NAME}", to: "neilospricey@gmail.com";
         }  
     }      
}