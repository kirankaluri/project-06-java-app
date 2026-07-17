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
        sh 'mvn clean compile'
    }
}

stage('Test') {
    steps {
        sh 'mvn test'
    }
}

stage('Package') {
    steps {
        sh 'mvn package'
    }
}

    post {

     always {
             archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }

        success {
            echo 'Pipeline Successful.'
        }

        failure {
            echo 'Pipeline Failed.'
        }
    }
}
}
