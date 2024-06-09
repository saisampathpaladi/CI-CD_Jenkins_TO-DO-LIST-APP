# to-do-list-cicd
    Prerequisites
1.Jenkins: Ensure Jenkins is installed and running.
2.Docker: Install Docker on the Jenkins server and agents.
3.Docker Compose: Install Docker Compose on the Jenkins server and agents.
4.GitHub Repository: The repository containing the To-Do List application.
5.Docker Hub Credentials: Store your Docker Hub credentials in Jenkins with the ID 'dc'.
    
    Setting Up the Pipeline
-Clone the repository: Ensure the repository is accessible from Jenkins.
-Configure Jenkins:
-Install the necessary Jenkins plugins: Git, Docker Pipeline, Credentials Binding.
-Create a Jenkins job and configure the pipeline script.
    Add Credentials:
-Go to Jenkins -> Manage Jenkins -> Manage Credentials.
-Add a new entry for Docker Hub with the ID 'dc'.
-Run the Pipeline: Trigger the Jenkins job to run the pipeline.
    Conclusion
This CI/CD pipeline automates the process of building, pushing, and deploying the To-Do List application. It ensures that the application is always up-to-date and tested, providing a reliable and efficient workflow.

For any issues or contributions, please raise an issue or submit a pull request in the repository or ping me an email saisampathpaladi@gmail.com.

This repository contains the CI/CD pipeline for the To-Do List application using Jenkins. The pipeline performs the following steps:
1. Clones the repository from GitHub.
2. Builds the Docker image for the application.
3. Pushes the Docker image to Docker Hub.
4. Deploys the application using Docker Compose.
5. Runs tests to ensure the application is working correctly.

## Pipeline Stages

### 1. Code
This stage clones the source code from the GitHub repository.

```groovy
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
stage("Test") {
    steps {
        echo "Running tests"
        // Add your test commands here
        // e.g., sh "pytest tests/"
    }
}
}

