Here are the answers to the **Kubernetes interview questions**:

---

## **Beginner-Level Questions**
### **1. What is Kubernetes?**  
Kubernetes is an open-source container orchestration platform that automates deploying, managing, and scaling containerized applications.

### **2. What are the main components of Kubernetes?**  
Kubernetes consists of:  
- **Control Plane** (API Server, Controller Manager, Scheduler, etcd)  
- **Worker Nodes** (Kubelet, Kube Proxy, Pods)

### **3. What is a Pod in Kubernetes?**  
A Pod is the smallest deployable unit in Kubernetes, consisting of one or more containers that share networking and storage.

### **4. What is a Node in Kubernetes?**  
A Node is a machine (virtual or physical) where Kubernetes runs containers. A cluster consists of multiple nodes.

### **5. What is a Deployment in Kubernetes?**  
A Deployment manages the lifecycle of Pods, ensuring the correct number of replicas and enabling rolling updates.

### **6. What is the role of Kubelet?**  
Kubelet runs on each node, ensuring that containers are running as expected.

### **7. What is the difference between a ReplicaSet and a ReplicationController?**  
ReplicaSet is an improved version of ReplicationController that supports set-based label selectors.

### **8. What are Labels and Annotations in Kubernetes?**  
- **Labels**: Key-value pairs used to group and select objects.  
- **Annotations**: Metadata attached to objects for storing non-identifying information.

### **9. How do you scale a deployment in Kubernetes?**  
By running:  
```sh
kubectl scale deployment my-deployment --replicas=5
```
or using **Horizontal Pod Autoscaler (HPA).**

### **10. What is the difference between StatefulSet and Deployment?**  
StatefulSet maintains stable network identities and persistent storage for each pod, whereas Deployment is stateless and used for scaling.

---

## **Intermediate-Level Questions**
### **11. What is the purpose of a Service in Kubernetes?**  
A Service exposes a set of Pods, ensuring stable networking even if Pods restart.

### **12. What are the different types of Services in Kubernetes?**  
- **ClusterIP** (default) – internal communication  
- **NodePort** – accessible on a static port on each node  
- **LoadBalancer** – integrates with cloud providers  
- **ExternalName** – maps a service to an external DNS

### **13. How does Kubernetes handle load balancing?**  
- Internally using **Services** (e.g., ClusterIP, LoadBalancer)  
- Externally using **Ingress Controller**  

### **14. What is a DaemonSet?**  
A DaemonSet ensures that a specific Pod runs on all (or some) nodes in the cluster.

### **15. What is the difference between ConfigMap and Secret?**  
- **ConfigMap** stores configuration data in key-value pairs.  
- **Secret** stores sensitive information like passwords (Base64 encoded).

### **16. How does Kubernetes perform rolling updates and rollbacks?**  
- Rolling update:  
  ```sh
  kubectl set image deployment/my-deployment my-container=my-image:v2
  ```
- Rollback:  
  ```sh
  kubectl rollout undo deployment my-deployment
  ```

### **17. What is a Persistent Volume (PV) and Persistent Volume Claim (PVC)?**  
- **PV**: Storage provisioned by an administrator.
A Persistent Volume (PV) is a storage resource in Kubernetes that provides durable storage to persist data beyond the lifecycle of individual pods.
  
- **PVC**: A request for storage by a Pod.
A Persistent Volume Claim (PVC) is a request for storage by a user in Kubernetes, specifying the size and access mode required, and it binds to a suitable Persistent Volume (PV) to provide the requested storage.

### **18. How does Kubernetes handle networking?**  
Kubernetes uses a flat networking model, allowing all Pods to communicate. It supports **CNI (Container Network Interface)** plugins like Flannel, Calico, and Cilium.

### **19. What is Ingress in Kubernetes?**  
Ingress is an API object that manages external access to services using rules and paths.

### **20. How do you troubleshoot a failing Pod in Kubernetes?**  
- Check logs:  
  ```sh
  kubectl logs pod-name
  ```
- Describe Pod:  The kubectl describe pod command is used to display detailed information about a specific pod in a Kubernetes cluster. 
  ```sh
  kubectl describe pod pod-name
  ```
- Check events:  
  ```sh
  kubectl get events
  ```

---

## **Advanced-Level Questions**
### **21. How does Kubernetes manage resource limits and requests?**  
- **Requests**: Minimum resources allocated to a container.  
- **Limits**: Maximum resources a container can use.

```yaml
resources:
  requests:
    cpu: "500m"
    memory: "256Mi"
  limits:
    cpu: "1"
    memory: "512Mi"
```

### **22. What are Taints and Tolerations in Kubernetes?**  
- **Taints**: Prevent certain workloads from being scheduled on a node.  
- **Tolerations**: Allow Pods to be scheduled on tainted nodes.

```sh
kubectl taint nodes node1 key=value:NoSchedule
```

### **23. What are Affinity and Anti-Affinity rules?**  
- **Affinity**: Prefer scheduling Pods on specific nodes.  
- **Anti-Affinity**: Avoid scheduling similar Pods together.

### **24. How does Kubernetes handle multi-tenancy?**  
By using **Namespaces, RBAC (Role-Based Access Control), and Network Policies** to isolate workloads.

### **25. What is the role of the Kubernetes API Server?**  
It exposes the Kubernetes API, handling authentication, validation, and communication between components.

### **26. Explain how etcd works in Kubernetes.**  
etcd is a distributed key-value store that stores cluster state and configuration.

### **27. How does Kubernetes ensure high availability?**  
- Multiple control plane nodes  
- Load balancing  
- Distributed etcd cluster  
- Replicated workloads across nodes

### **28. What is a Custom Resource Definition (CRD) in Kubernetes?**  
A CRD allows users to define their own API objects, extending Kubernetes functionality.

```sh
kubectl apply -f my-crd.yaml
```

### **29. How can you secure a Kubernetes cluster?**  
- **Enable RBAC**: Define roles and only give users the access they need.  
- **Use Network Policies**: Limit pod-to-pod communication based on need.  
- **Encrypt secrets**:  
- **Enable Audit Logs**: Helps trace what happened and when. 
- **Use Pod Security Policies**: To enforce security standards.  

### **30. What is Kubernetes Federation?**  
Federation allows managing multiple clusters as a single unit for high availability and disaster recovery.

---

Here are the key Kubernetes components explained in a single line:

1. **Master Node**: The control plane that manages the Kubernetes cluster, including scheduling, API, and orchestration.
2. **API Server**: Exposes the Kubernetes API, handling requests from clients (e.g., `kubectl`) and other components.
3. **Scheduler**: Decides which node should run each pod based on resource availability and constraints.
4. **Controller Manager**: Maintains the desired state of the cluster by continuously monitoring and correcting the state of resources.
5. **Kubelet**: An agent running on each node, ensuring containers are running as expected based on pod specifications.
6. **Kube Proxy**: Maintains network rules and enables communication to and from pods within the cluster.
7. **Etcd**: A distributed key-value store used to store the cluster's configuration data and state.
8. **Node**: A worker machine in the cluster that runs containers (pods) and provides the runtime environment.
9. **Pod**: The smallest deployable unit in Kubernetes, which encapsulates one or more containers.
10. **ReplicaSet**: Ensures a specified number of identical pods are running at any given time.
11. **Deployment**: Manages the rollout and scaling of applications by controlling replica sets and pods.
12. **Service**: Exposes a set of pods as a network service, enabling communication across the cluster.
13. **Namespace**: Provides a way to partition the cluster into isolated environments for better resource management.
14. **Ingress**: Manages external HTTP/HTTPS access to services within the cluster, typically for routing and load balancing.
15. **ConfigMap**: Stores non-sensitive configuration data that can be used by containers.
16. **Secret**: Stores sensitive data (like passwords and API keys) securely within Kubernetes.
17. **StatefulSet**: Manages stateful applications, ensuring stable, unique network identifiers and persistent storage for pods.


### 🩺 2. **What is Readiness and Liveness Probe in Kubernetes?**

#### **Liveness Probe:**
- Tells **if the app is still alive**.
- If this fails, the pod is **restarted**.
- Example use: app gets stuck in a deadlock.

#### **Readiness Probe:**
- Tells **if the app is ready to serve requests**.
- If this fails, the pod is **removed from service/load balancer** but **not restarted**.
- Example use: app is still starting up or loading configs.

**Common Probe Types:**
- HTTP: GET request to a specific path.
- TCP: Opens a socket connection.
- Command: Executes a script/command inside the container.
