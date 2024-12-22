pipeline {
    agent any

    parameters {
        string(name: 'WHOAMI', defaultValue: 'FahamiKareem', description: 'User name')
        string(name: 'PROJECT', defaultValue: 'FinanceMe', description: 'Project name')
        string(name: 'GIT_URL', defaultValue: 'https://github.com/fahamikareem/FinanceMe_2112.git', description: 'Repository URL')
    }
    
    environment {
        AGENT_USER = 'ubuntu'
        AGENT_IP = '44.211.167.77'
        PROJECT_DIRECTORY= 'FinanceMe_2112'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Getting the code from Repository ${params.PROJECT} for user ${params.WHOAMI}"
                git "${params.GIT_URL}"
            }
        }

        stage('Agent-Configuration and Compile') {
            steps {
                sshagent(['SSHAgent01']) {
                    script {
                        echo "Copying configuration script to remote agent"
                        sh "scp -o StrictHostKeyChecking=no agent_config.sh ${AGENT_USER}@${AGENT_IP}:~ "
                        sh "ssh -o StrictHostKeyChecking=no ${AGENT_USER}@${AGENT_IP}  'bash agent_config.sh' "
                    }
                }
            }
        }

        stage('Build') {
            steps {
                sshagent(['SSHAgent01']) {
                    script {
                        echo "Building the code"
                        sh "ssh -o StrictHostKeyChecking=no ${AGENT_USER}@${AGENT_IP} 'pwd' && 'mvn compile' "
                    }
                }
            }
        }

        stage('Test') {
            steps {
                sshagent(['SSHAgent01']) {
                    script {
                        echo "Testing the code"
                        sh "ssh -o StrictHostKeyChecking=no ${AGENT_USER}@${AGENT_IP} 'cd $PROJECT_DIRECTORY' && 'mvn test'"
                    }
                }
            }
        }

        stage('Package') {
            steps {
                sshagent(['SSHAgent01']) {
                    script {
                        echo "Packaging the code"
                        sh "ssh -o StrictHostKeyChecking=no ${AGENT_USER}@${AGENT_IP} 'cd $PROJECT_DIRECTORY' && 'mvn package'"
                    }
                }
            }
        }
    }
}
