pipeline {
    agent any
    environment {
        CI = 'true'
        GIT_COMMIT_AUTHOR = ''
        GIT_COMMIT_EMAIL = '' 
    }
    stages {
        stage('Pre') {
            environment {
                GIT_COMMIT_AUTHOR = sh(returnStdout: true, script: "git log -1 --pretty=format:'%an'").trim()
            }            
            steps {
                script {    
                    sh "echo $GIT_COMMIT_AUTHOR; echo ${env.GIT_COMMIT_AUTHOR};"
                }
            }
        }
        stage('Pre2') {
            steps {
                script {    
                    GIT_COMMIT_EMAIL = sh(returnStdout: true, script: "git log -1 --pretty=format:'%ae'").trim()
                }
            }
        }                
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
             mail bcc: '', body: "<b>Example</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL of the build: ${env.BUILD_URL} <br> ${env.GIT_COMMIT} <br> ${env.GIT_COMMIT_AUTHOR} <br> ${env.GIT_COMMIT_EMAIL} <br> ${env.GIT_URL} <br> ${env.GIT_BRANCH}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "ERROR CI: Project name -> ${env.JOB_NAME}", to: "neilospricey@gmail.com";
         }  
     }      
}