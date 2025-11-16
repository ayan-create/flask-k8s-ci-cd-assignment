# Flask Kubernetes CI/CD Assignment

## 📌 Project Overview

This project demonstrates a complete CI/CD pipeline for deploying a
Flask application to a Kubernetes cluster using **GitHub Actions**,
**Jenkins**, **Docker**, and **Minikube**.\
It includes: - Automated CI using GitHub Actions\
- Automated CD using Jenkins\
- Containerization using Docker\
- Deployment to Kubernetes\
- Rolling updates, scaling, and load balancing

------------------------------------------------------------------------

## 🚀 Technologies & Kubernetes Features Used

### **Kubernetes Features**

-   **Deployment** with Rolling Update strategy
    -   `maxSurge` and `maxUnavailable` configured\
-   **Horizontal Scaling** using multiple replicas\
-   **Load Balancing** via a NodePort Service\
-   **Resource Requests & Limits** to ensure stable workload
    distribution\
-   **Rollout Management**
    -   `kubectl rollout status`
    -   `kubectl rollout undo`

------------------------------------------------------------------------

## 🐳 Build & Run Flask App Locally with Docker

### **1. Build Docker Image**

``` bash
docker build -t flask-k8s-ci-cd-assignment:latest .
```

### **2. Run Docker Container**

``` bash
docker run -p 5000:5000 flask-k8s-ci-cd-assignment:latest
```

### **3. Test Application**

Visit:

    http://localhost:5000

------------------------------------------------------------------------

## ☸️ Deploy to Kubernetes Using Jenkins Pipeline

Once the PR is merged into the **main branch**, Jenkins will
automatically:

1.  Start Minikube\
2.  Build the Docker image inside Minikube's Docker daemon\
3.  Apply Kubernetes manifests\
4.  Verify rollout and deployment

### **Manual Trigger**

You can also manually trigger the Jenkins job if webhooks aren't
enabled.

------------------------------------------------------------------------

## ⚙️ Automated Features in Kubernetes

### ✔ Automated Rollouts

-   The Deployment ensures zero downtime updates.
-   You can monitor progress:

``` bash
kubectl rollout status deployment/flask-deployment
```

### ✔ Scaling (Horizontal Pod Autoscaling Ready)

You can scale manually for demonstration:

``` bash
kubectl scale deployment flask-deployment --replicas=4
```

### ✔ Load Balancing

The NodePort Service distributes traffic across all pods:

``` bash
kubectl get svc
```

Access via:

    http://<minikube-ip>:<nodeport>

------------------------------------------------------------------------

## 📄 Full Pipeline Workflow Summary

1.  Developer pushes code → GitHub Actions runs CI\
2.  Code merged to main → Jenkins runs CD\
3.  Jenkins builds image + deploys to Kubernetes\
4.  Kubernetes manages scaling, rolling updates & load balancing\
5.  Application becomes available on Minikube service URL

------------------------------------------------------------------------

## 👥 Contributors

-   **Admin** -- Repository setup, reviews, approvals\
-   **Developer** -- Feature development, pipelines, manifests

------------------------------------------------------------------------

## ✅ End-to-End Verified

This project has been tested end-to-end, ensuring: - CI triggers
correctly\
- CD deploys successfully\
- Application runs on Kubernetes\
- Scaling, rollout, and load balancing are fully functional
