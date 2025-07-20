To install Ingress Controller on your Kubernetes cluster (using kubeadm with Calico), follow the steps below. We'll use NGINX Ingress Controller, which is the most commonly used.


---

✅ Prerequisites

Kubernetes is installed (master + workers joined).

kubectl is configured on your master.

You have a working network plugin (e.g., Calico).



---

🚀 Step-by-Step: Install NGINX Ingress Controller

🔹 Step 1: Create a dedicated namespace

```
kubectl create namespace ingress-nginx
```

---

🔹 Step 2: Install NGINX Ingress Controller using official YAML

Use this command (for Kubernetes v1.25+):

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.6/deploy/static/provider/cloud/deploy.yaml
```

This will install:

Deployment (ingress-nginx-controller)

Service (default is LoadBalancer or NodePort)

RBAC resources



---

🔹 Step 3: Verify the installation

```
kubectl get all -n ingress-nginx
```

You should see a pod like:

ingress-nginx-controller-xxxxxxxxxxxx   Running


---

🔹 Step 4: Expose Ingress via NodePort (if not using cloud load balancer)

If you’re on bare metal or VMs:

```
kubectl edit svc ingress-nginx-controller -n ingress-nginx
```

Find this section:

```
type: LoadBalancer
```

Change it to:

```
type: NodePort
```

Save and exit.

Then check which port was assigned:

```
kubectl get svc ingress-nginx-controller -n ingress-nginx
```

Look under the PORT(S) column — you’ll see something like:

```
80:32345/TCP
443:32456/TCP
```

---

🔹 Step 5: Test with a sample app (Optional)

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
  namespace: default
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
    - host: myapp.local
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: my-service
                port:
                  number: 80
```

---

✅ Summary of Commands

```
kubectl create namespace ingress-nginx
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.6/deploy/static/provider/cloud/deploy.yaml
kubectl get pods -n ingress-nginx
kubectl edit svc ingress-nginx-controller -n ingress-nginx   # Change to NodePort
```
