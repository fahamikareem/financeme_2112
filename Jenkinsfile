pipeline {
    agent any

    parameters {
        string(name: 'WHOAMI', defaultValue: 'FahamiKareem', description: 'User name')
        string(name: 'PROJECT', defaultValue: 'FinanceMe', description: 'Project name')
        string(name: 'REPO_URL', defaultValue: 'https://github.com/fahamikareem/FinanceMe_2112.git', description: 'Repository URL')
    }
    
    environment {
        AGENT_USER = 'ubuntu'
        AGENT_IP = '44.211.167.77'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Getting the code from Repository ${params.PROJECT} for user ${params.WHOAMI}"
                git "${params.REPO_URL}"
            }
        }

        stage('Agent-Configuration') {
            steps {
                sshagent(['SSHAgent1']) {
                    script {
                        echo "Copying configuration script to remote agent"
                        sh "ssh -o StrictHostKeyChecking=no ${AGENT_USER}@${AGENT_IP} 'mkdir FinanceMe_2112' "
                        sh "scp -o StrictHostKeyChecking=no . ${AGENT_USER}@${AGENT_IP}:~/FinanceMe_2112 "
                        sh "ssh -o StrictHostKeyChecking=no ${AGENT_USER}@${AGENT_IP} 'cd FinanceMe_2112 && bash agent_config.sh' "
                    }
                }
            }
        }

        stage('Build') {
            steps {
                sshagent(['SSHAgent1']) {
                    script {
                        echo "Building the code"
                        sh "ssh -o StrictHostKeyChecking=no ${AGENT_USER}@${AGENT_IP} 'mvn compile'"
                    }
                }
            }
        }

        stage('Test') {
            steps {
                sshagent(['SSHAgent1']) {
                    script {
                        echo "Testing the code"
                        sh "ssh -o StrictHostKeyChecking=no ${AGENT_USER}@${AGENT_IP} 'mvn test'"
                    }
                }
            }
        }

        stage('Package') {
            steps {
                sshagent(['SSHAgent1']) {
                    script {
                        echo "Packaging the code"
                        sh "ssh -o StrictHostKeyChecking=no ${AGENT_USER}@${AGENT_IP} 'mvn package'"
                    }
                }
            }
        }
    }
}
