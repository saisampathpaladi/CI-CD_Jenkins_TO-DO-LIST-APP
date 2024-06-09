pipeline {
    agent any
    
    stages {
        stage("Code") {
            steps {
                echo "Cloning the code"
                git url: "https://github.com/saisampathpaladi/to-do-list-cicd.git", branch: "main"
            }
        }
        stage("Build") {
            steps {
                echo "Building the code"
                sh "docker build -t to-do ."
            }
        }
        stage("Push to dockerhub") {
            steps {
                echo "Pushing the code to Docker Hub"
                withCredentials([usernamePassword(credentialsId: 'dc', passwordVariable: 'dockerhubpass', usernameVariable: 'dockerhubusr')]) {
                    sh """
                        docker login -u ${dockerhubusr} -p ${dockerhubpass}
                        docker tag to-do ${dockerhubusr}/to-do:latest
                        docker push ${dockerhubusr}/to-do:latest
                    """
                }
            }
        }
        stage("Deploy") {
            steps {
                echo "Deploying the code to agents"
                sh """
                    docker-compose down
                    docker-compose up -d
                """
            }
        }
        stage("Test") {
            steps {
                echo "Running tests"
                // Add your test commands here
                // e.g., sh "pytest tests/"
            }
        }
    }
}
