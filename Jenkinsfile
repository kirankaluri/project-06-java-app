pipeline {

    agent {
        label 'linux'
    }

    options {
        timestamps()
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    environment {
        APP_NAME = 'project06-java-app'
        MAVEN_OPTS = '-Xmx1024m'
    }

    stages {

        stage('Checkout') {
            steps {
                echo '========== CHECKOUT =========='
                checkout scm
            }
        }

        stage('Environment Information') {
            steps {
                sh '''
                    echo "========================================="
                    echo "Environment Information"
                    echo "========================================="
                    echo "*****************************************"

                    echo "Hostname:"
                    hostname

                    echo
                    echo "Workspace:"
                    pwd

                    echo
                    echo "Java Version:"
                    java -version

                    echo
                    echo "Git Version:"
                    git --version

                    echo
                    echo "Docker Version:"
                    docker --version

                    echo
                    echo "Maven Version:"
                    mvn -version

                    echo
                    echo "Current User:"
                    whoami

                    echo
                    echo "Repository Files:"
                    ls -la
                '''
            }
        }

        stage('Build') {
            steps {
                echo '========== BUILD =========='
                sh 'mvn clean compile'
            }
        }

        stage('Unit Test') {
            steps {
                echo '========== UNIT TEST =========='
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                echo '========== PACKAGE =========='
                sh 'mvn package'
            }
        }

        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
    }

    post {

        always {
            echo 'Cleaning Workspace...'
            cleanWs()
        }

        success {
            echo '====================================='
            echo 'Pipeline Completed Successfully'
            echo '====================================='
        }

        failure {
            echo '====================================='
            echo 'Pipeline Failed'
            echo '====================================='
        }

        unstable {
            echo 'Pipeline is Unstable'
        }

        aborted {
            echo 'Pipeline Aborted'
        }
    }
}
