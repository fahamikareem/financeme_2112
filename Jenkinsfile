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

        stage('Agent-Configuration and Maven- Build Test Package') {
            steps {
                sshagent(['SSHAgent01']) {
                    script {
                        echo "Agent config and Executing Maven Compile, Test, Packaging"
                        sh "scp -o StrictHostKeyChecking=no agent_config.sh ${AGENT_USER}@${AGENT_IP}:~ "
                        sh "ssh -o StrictHostKeyChecking=no ${AGENT_USER}@${AGENT_IP}  'bash agent_config.sh' "
                    }
                }
            }
        }     
    }
}
