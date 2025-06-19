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
		export LD_LIBRARY_PATH=/opt/ace-12.0.2.0/common/jdk/jre/lib/amd64:/opt/ace-12.0.2.0/common/jdk/jre/lib/amd64/classic:/opt/ace-12.0.2.0/common/jdk/jre/lib/icc:/opt/ace-12.0.2.0/common/jdk/lib/default:/opt/ace-12.0.2.0/common/jdk/lib/server:/opt/ace-12.0.2.0/common/jdk/lib:/opt/ace-12.0.2.0/ie02/lib:/var/mqsi/extensions/12.0.2/server/lib:/var/mqsi/extensions/12.0.2/lib:/opt/ace-12.0.2.0/server/xml4c/lib:/opt/ace-12.0.2.0/server/lib:/opt/ace-12.0.2.0/server/bin:/opt/ace-12.0.2.0/server/ODBC/drivers/lib:/opt/ace-12.0.2.0/server/xlxpc/lib:/opt/ace-12.0.2.0/server/dfdlc/lib
		export LANG=en_US.UTF-8
		/opt/ace-12.0.2.0/server/bin/mqsideploy ${env.NODE} -e ${env.EG} -b ${env.BASE_DIR}/Source/${env.DEPLOY_PATH}/${env.DEPLOY_PATH}.bar
                """
            }
        }
                 
    }
}

