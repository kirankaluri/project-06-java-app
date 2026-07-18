pipeline {

    agent {
        label 'linux'
    }

    options {
        timestamps()
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    tools {
        maven 'Maven3'
    }

    environment {
        APP_NAME = 'project06-java-app'
    }

    stages {

        stage('Checkout') {
            steps {
                echo "========== CHECKOUT =========="
                checkout scm
            }
        }

        stage('Environment Information') {
            steps {
                sh '''
                    echo "=================================="
                    echo "Environment Information"
                    echo "=================================="

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
                    echo "Files:"
                    ls -la
                '''
            }
        }

        stage('Build') {
            steps {
                echo "========== BUILD =========="
                sh 'mvn clean compile'
            }
        }

        stage('Unit Test') {
            steps {
                echo "========== UNIT TEST =========="
                sh 'mvn test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo "========== SONARQUBE ANALYSIS =========="

                withSonarQubeEnv('SonarQube') {

                    sh '''
                        mvn sonar:sonar \
                        -Dsonar.projectKey=project06-java-app \
                        -Dsonar.projectName="Project 06 Java App"
                    '''
                }
            }
        }

        stage('Quality Gate') {
            steps {

                timeout(time: 5, unit: 'MINUTES') {

                    waitForQualityGate abortPipeline: true

                }

            }
        }

        stage('Package') {
            steps {
                echo "========== PACKAGE =========="
                sh 'mvn package'
            }
        }

        stage('Archive Artifact') {
            steps {

                archiveArtifacts artifacts: 'target/*.jar',
                                 fingerprint: true

            }
        }

    }

    post {

        always {

            echo "Cleaning Workspace..."

            cleanWs()

        }

        success {

            echo '''
=========================================
Pipeline Completed Successfully
=========================================
'''

        }

        failure {

            echo '''
=========================================
Pipeline Failed
=========================================
'''

        }

        unstable {

            echo "Pipeline is Unstable"

        }

        aborted {

            echo "Pipeline Aborted"

        }

    }

}

stage('Docker Build') {
    steps {
        echo "========== DOCKER BUILD =========="

        sh '''
            docker build -t project06-java-app:${BUILD_NUMBER} .
        '''
    }
}

stage('Docker Image Verification') {
    steps {
        echo "========== DOCKER IMAGES =========="

        sh '''
            docker images | grep project06-java-app
        '''
    }
}
