pipeline {
    agent any

    stages {

        // ---------------------------------------------------
        // STAGE 1 — Start Minikube Using Docker Desktop Driver
        // ---------------------------------------------------
        stage("Start Minikube") {
            steps {
                echo "Starting Minikube using Docker Desktop driver..."

                powershell '''
                Write-Host "Checking Minikube status..."
                $status = minikube status

                if ($status -notmatch "host: Running") {
                    Write-Host "Minikube not running. Starting..."
                    minikube start --driver=docker --memory=4096 --cpus=2
                } else {
                    Write-Host "Minikube already running."
                }

                Write-Host "Verifying Minikube status..."
                minikube status
                '''
            }
        }

        // ---------------------------------------------------------
        // STAGE 2 — Build Docker Image in Minikube Docker Daemon
        // ---------------------------------------------------------
        stage("Build Docker Image") {
            steps {
                echo "Building Docker image inside Minikube’s Docker environment..."

                powershell '''
                Write-Host "Switching Docker daemon to Minikube..."
                minikube -p minikube docker-env --shell powershell | Invoke-Expression

                Write-Host "Docker Daemon switched. Building image..."
                docker build -t flask-k8s-ci-cd-assignment:latest .

                Write-Host "Listing Docker images..."
                docker images
                '''
            }
        }

        // -------------------------------------------------------
        // STAGE 3 — Apply Kubernetes Deployment + Service
        // -------------------------------------------------------
        stage("Deploy to Kubernetes") {
            steps {
                echo "Applying Kubernetes manifests..."

                powershell '''
                Write-Host "Applying Deployment..."
                kubectl apply -f ".\\kubernetes\\deployment.yaml"

                Write-Host "Applying Service..."
                kubectl apply -f ".\\kubernetes\\service.yaml"
                '''
            }
        }

        // -----------------------------------------------------------
        // STAGE 4 — Verify Rollout, Pods, and Service Availability
        // -----------------------------------------------------------
        stage("Verify Deployment") {
            steps {
                echo "Verifying rollout status and Kubernetes resources..."

                powershell '''
                Write-Host "Checking rollout status..."
                kubectl rollout status deployment/flask-deployment

                Write-Host "Fetching pods..."
                kubectl get pods -o wide

                Write-Host "Fetching services..."
                kubectl get services -o wide

                Write-Host "Fetching deployments..."
                kubectl get deployments
                '''
            }
        }
    }

    // ----------------------------
    // CLEANUP AFTER EVERY BUILD
    // ----------------------------
    post {
        always {
            echo "Stopping Minikube cluster..."

            powershell '''
            Write-Host "Stopping Minikube..."
            minikube stop
            '''
        }
    }
}
