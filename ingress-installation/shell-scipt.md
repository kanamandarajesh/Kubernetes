Yes! Here's a complete shell script to install the NGINX Ingress Controller on your Kubernetes cluster using kubectl (suitable for kubeadm-based bare metal or VM setups like yours):


---

✅ install-ingress-nginx.sh

#!/bin/bash

set -e

echo "[INFO] Creating ingress-nginx namespace..."
kubectl create namespace ingress-nginx || echo "[WARN] Namespace already exists."

echo "[INFO] Deploying ingress-nginx controller..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.6/deploy/static/provider/cloud/deploy.yaml

echo "[INFO] Waiting for ingress-nginx controller pod to be ready..."
kubectl wait --namespace ingress-nginx \
  --for=condition=Ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s

echo "[INFO] Changing service type to NodePort..."
kubectl patch svc ingress-nginx-controller \
  -n ingress-nginx \
  -p '{"spec": {"type": "NodePort"}}'

echo "[INFO] Ingress controller installation complete."
kubectl get svc -n ingress-nginx


---

🔧 How to Use

1. Save the script as install-ingress-nginx.sh on your master node.


2. Make it executable:

chmod +x install-ingress-nginx.sh


3. Run the script:

./install-ingress-nginx.sh




---

📌 Output Sample

The script will:

Create the namespace (or skip if it exists)

Apply the official manifest

Wait for the pod to become ready

Change the service from LoadBalancer to NodePort

Show the assigned ports for HTTP/HTTPS access



---

Let me know if you want an additional script for testing ingress with a demo app.
