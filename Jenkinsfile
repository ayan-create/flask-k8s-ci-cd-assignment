pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "flask-k8s-ci-cd-app:latest"
        KUBE_NAMESPACE = "default"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                echo "Building Docker Image..."
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo "Applying Kubernetes manifests..."
                sh 'kubectl apply -f kubernetes/'
            }
        }

        stage('Verify Deployment') {
            steps {
                echo "Checking rollout status..."
                sh 'kubectl rollout status deployment/flask-app'
                echo "Listing Pods and Services..."
                sh 'kubectl get pods'
                sh 'kubectl get services'
            }
        }
    }

    post {
        success {
            echo "Deployment to Kubernetes succeeded!"
        }
        failure {
            echo "Deployment failed. Check logs."
        }
    }
}
