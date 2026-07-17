pipeline {
    agent any

    stages {

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

    }

    post {
        always {
            echo 'Pipeline finished'
        }

        success {
            echo 'SUCCESS'
        }

        failure {
            echo 'FAILED'
        }
    }
}
