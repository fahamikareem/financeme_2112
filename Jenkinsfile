pipeline {
    agent any

    parameters {
        string(name: 'WHOAMI', defaultValue: 'FahamiKareem', description: 'User name')
        string(name: 'PROJECT', defaultValue: 'FinanceMe', description: 'Project name')
        string(name: 'REPO_URL', defaultValue: 'https://github.com/fahamikareem/FinanceMe_2112.git', description: 'Repository URL')
    }
    
    environment{
        AGENT_USER='ec2-user'
        AGENT_IP='54.167.114.220'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Getting the code from Repository ${params.PROJECT} for user ${params.WHOAMI}"
                git "${params.REPO_URL}"
            }
        }

        stage('Agent Config') {
            steps {
                echo "Copying configuration script to remote agent"
                sh "scp -o StrictHostKeyChecking=no agent_config.sh ${AGENT_USER}@${AGENT_IP}:/home/ec2-user"
                sh "ssh -o strictHostKeyChecking=no ${AGENT_USER}@${AGENT_IP} 'bash /home/ubuntu/agent_config.sh"
            }
        }

        stage('Build') {
            steps {
                echo 'Compiling the code'
                sh 'mvn compile'
            }
        }

        stage('Test') {
            steps {
                echo 'Testing the code using Maven'
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                echo 'Packaging the application - JAR'
                sh 'mvn package'
            }
        }
    }
}
