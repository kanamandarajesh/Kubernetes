Absolutely! Here's a **cheat sheet** of the **most important Kubernetes (kubectl) commands** categorized by common use cases:

---

## 🔍 **1. Cluster Information**

```bash
kubectl cluster-info              # Show cluster details
kubectl get nodes                 # List all nodes
kubectl describe node <node>     # Show detailed info of a node
```

---

## 📦 **2. Pods**

```bash
kubectl get pods                          # List all pods
kubectl get pods -o wide                  # With IP and node info
kubectl describe pod <pod-name>           # Detailed pod info
kubectl logs <pod-name>                   # Show logs of a pod
kubectl exec -it <pod-name> -- /bin/sh    # Access shell inside a pod
kubectl delete pod <pod-name>             # Delete a pod
```

---

## 📂 **3. Deployments**

```bash
kubectl get deployments                   # List deployments
kubectl describe deployment <name>        # Detailed deployment info
kubectl scale deployment <name> --replicas=3   # Scale up/down
kubectl rollout restart deployment <name>      # Restart deployment
kubectl delete deployment <name>          # Delete deployment
```

---

## 🔗 **4. Services**

```bash
kubectl get svc                           # List services
kubectl describe svc <service-name>       # Detailed service info
kubectl expose deployment <name> --type=NodePort --port=80    # Expose service
```

---

## 📜 **5. YAML (Declarative Approach)**

```bash
kubectl apply -f <file.yaml>              # Create/update from YAML
kubectl delete -f <file.yaml>             # Delete from YAML
kubectl create -f <file.yaml>             # Create resource
kubectl edit <resource>/<name>            # Edit live YAML (vi editor)
kubectl get all                           # Get all resources in default namespace
```

---

## 📁 **6. Namespaces**

```bash
kubectl get namespaces                    # List all namespaces
kubectl create namespace <name>           # Create a new namespace
kubectl delete namespace <name>           # Delete a namespace
kubectl config set-context --current --namespace=<name>   # Switch default namespace
```

---

## 📌 **7. ConfigMaps & Secrets**

```bash
kubectl create configmap my-config --from-literal=key=value     # Create ConfigMap
kubectl get configmaps                                          # List ConfigMaps
kubectl describe configmap my-config                            # Show ConfigMap

kubectl create secret generic my-secret --from-literal=password=1234   # Create Secret
kubectl get secrets                                                     # List Secrets
```

---

## 📅 **8. Events & Troubleshooting**

```bash
kubectl get events                     # Show recent cluster events
kubectl describe pod <name>            # Check for crash reasons
kubectl get pods --all-namespaces      # List all pods in all namespaces
kubectl top pod                        # Show resource usage (needs metrics-server)
```

---

## 🧪 **9. Port Forwarding & Testing**

```bash
kubectl port-forward svc/<service> 8080:80        # Access service on localhost:8080
kubectl port-forward pod/<pod-name> 8080:80       # Direct to pod
```

---

## 📦 **10. Helm (if using)**

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install myapp bitnami/nginx                   # Install chart
helm list                                          # List installed charts
helm uninstall myapp                               # Delete release
```

---
