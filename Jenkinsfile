pipeline {
    agent slave01
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/fahamikareem/FinanceMe.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn compile'
            }
        }
        stage('test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('package') {
            steps {
                sh 'mvn package'
            }
        }