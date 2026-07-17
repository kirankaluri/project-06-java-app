pipeline {

    agent { label 'linux' }

    options {
        timestamps()
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                checkout scm
            }
        }

        stage('Environment Information') {
            steps {
                sh '''
                    echo "Hostname:"
                    hostname

                    echo "Current Directory:"
                    pwd

                    echo "Java Version:"
                    java -version

                    echo "Git Version:"
                    git --version

                    echo "Docker Version:"
                    docker --version

                    echo "Maven Version:"
                    mvn -version
                '''
            }
        }

        stage('Build') {
            steps {
                sh '''
                    echo "Starting Build..."
                    ls -la
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    echo "Running Tests..."
                    echo "No tests available."
                '''
            }
        }

        stage('Package') {
            steps {
                sh '''
                    echo "Packaging Application..."
                '''
            }
        }
    }

    post {

        always {
            echo 'Pipeline Finished.'
        }

        success {
            echo 'Pipeline Successful.'
        }

        failure {
            echo 'Pipeline Failed.'
        }
    }
}
