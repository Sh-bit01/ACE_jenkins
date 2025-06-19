pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/Sh-bit01/ACE_jenkins.git'
        REPO_NAME = 'ACE_jenkins'
        BASE_DIR = '/home/ubuntu/jenkins'
        NODE = 'ACE'
	EG = 'jenkins'
    }

    stages {
        stage('Checkout') {
            steps {
                dir("${env.BASE_DIR}/ACE_jenkins") {
                    // If you still want to manually check this folder
                    script {
                        if (fileExists("${env.BASE_DIR}/ACE_jenkins")) {
                            echo "Directory ACE_jenkins exists. Pulling latest changes..."
                            sh "cd ${env.BASE_DIR}/ACE_jenkins && git pull"
                        } else {
                            echo "Directory ACE_jenkins not found. Cloning repository..."
                            sh "git clone ${env.REPO_URL} ${env.BASE_DIR}/ACE_jenkins"
                        }
                    }
                }
            }
        }

        stage('Prepare for Deploy') {
            steps {
                script {
                    env.DEPLOY_PATH = sh(
                        script: "tail -n 1 ${env.BASE_DIR}/ACE_jenkins/DeployList",
                        returnStdout: true
                    ).trim()
                    echo "Deploy Path: ${env.DEPLOY_PATH}"
                }
                sh """
                    cp -r ${env.DEPLOY_PATH} ${env.BASE_DIR}/Build/
                """
            }
        }

        stage('Create BAR File') {
            steps {
                sh """
                    Xvfb :99 -screen 0 1024x768x24 &
                    export DISPLAY=:99
                    cd ${env.BASE_DIR}/Build/
                    /opt/ace-12.0.2.0/tools/mqsicreatebar -data ${env.BASE_DIR}/${env.REPO_NAME} -a ${env.DEPLOY_PATH} -p ${env.DEPLOY_PATH} -b ${env.BASE_DIR}/Source/${env.DEPLOY_PATH}/${env.DEPLOY_PATH}.bar
                """
            }
        }
        
        
        stage('deploying') {
            steps {
                sh """
		/opt/ace-12.0.2.0/server/bin/mqsideploy ${env.NODE} -e ${env.EG} -b ${env.BASE_DIR}/Source/${env.DEPLOY_PATH}/${env.DEPLOY_PATH}.bar


                """
            }
        }
        
        
        
        
        
        
        
        
        
    }
}

