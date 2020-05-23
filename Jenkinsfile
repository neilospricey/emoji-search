pipeline {
    agent any
    environment {
        CI = 'true'
        GIT_COMMIT_AUTHOR = ''
        GIT_COMMIT_EMAIL = '' 
    }
    stages {
        stage('SetPostEnvVars') {     
            steps {
                script { 
                    sh '''
                        git log -1 --pretty=format:'%an' | tr "\n" " " > jenkins_envvars_name
                        git log -1 --pretty=format:'%ae' | tr "\n" " " > jenkins_envvars_email
                        git log -1 --pretty=oneline | tr "\n" " " > jenkins_envvars_details
                    '''   
                }
            }
        }
        stage('Pre2') {
            steps {
                script {    
                    sh 'cat jenkins_envvars_name; cat jenkins_envvars_email; cat jenkins_envvars_details'
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
        always {
            echo 'I will always say Hello again!'
            
            emailext body: 'A Test EMail', recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']], subject: 'Test'
            
        }
     }      
}

