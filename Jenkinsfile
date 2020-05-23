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
            
            emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
                recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
                subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}"
            
        }
        failure {  
            notifyFailed()
        }  
     }      
}


def notifyFailed() {
    def mailRecipients = "neilospricey@gmail.com"
    def emailBody = """<p>FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p><p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>"""
    def emailSubject = "${env.JOB_NAME} - Build# ${env.BUILD_NUMBER} - ${env.BUILD_STATUS}"
    mail bcc: '', body: "<b>Example</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL of the build: ${env.BUILD_URL} <br> ${env.GIT_COMMIT} <br> ${env.GIT_COMMIT_AUTHOR} <br> ${env.GIT_COMMIT_EMAIL} <br> ${env.GIT_URL} <br> ${env.GIT_BRANCH}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "ERROR CI: Project name -> ${env.JOB_NAME}", to: "neilospricey@gmail.com";
    emailext(mimeType: 'text/html', replyTo: '$DEFAULT_RECIPIENTS', subject: emailSubject, to: '$DEFAULT_RECIPIENTS', body: emailBody)
}