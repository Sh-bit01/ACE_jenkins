pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Sh-bit01/jenkins_spring.git'
            }
        }
    
    stages {
        stage('Test') {
            steps {
                echo "Hello from branch ${env.BRANCH_NAME}"
            }
        }
    }
}
