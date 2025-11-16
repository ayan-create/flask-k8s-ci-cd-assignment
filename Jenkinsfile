pipeline {
    agent any

    stages {
        stage("start minikube") {
            steps {
                echo "starting minikube" 
                bat 'minikube start --driver=docker'
            }
        }

        stage('build docker image to minikube') {
            steps {
                echo "building docker image insider minikube docker daemon" 
                bat '''
                minikube -p minikube docker-env --shell cmd > minikube-env.bat 
                call minikube-env.bat 
                docker build -t flask-k8s-ci-cd-assignment:latest .
                docker images 
                '''
            }
        }

        stage('deploy to kubernetes') {
            steps {
                echo "deploying to minikube k8s cluster" 
                bat '''
                kubectl apply -f deployment.yaml
                kubectl apply -f service.yaml
                '''
            }
        }

        stage('verify deployment') {
            steps {
                bat '''
                // kubectl rollout status deployment/flask-app 
                kubectl get pods 
                kubectl get service
                '''
            }
        }


    }
    
    post {
        always {
            echo "stopping minikube cluster" 
            bat 'minikube stop' 
        }
    }

}
