pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/Sh-bit01/ACE_jenkins.git'
            }
        }

        stage('Test') {
            steps {
                echo "Hello from branch ${env.BRANCH_NAME}"
            }
        }
    }
}
