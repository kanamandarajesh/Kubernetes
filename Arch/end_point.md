To **create** or **find an endpoint** in a Kubernetes microservices environment, you need to identify:

> 🧭 **What is exposed**, **how it is exposed**, and **where the user or other services access it**.

Let’s break it down into **how to find existing endpoints**, and **how to create new ones**.

---

## ✅ PART 1: How to **FIND** Existing Endpoints

### 🔍 1. **Check Ingress (External HTTP Endpoints)**

```bash
kubectl get ingress -A
```

#### Example output:

```
NAMESPACE   NAME           HOSTS                  PATHS       SERVICE        PORT
default     my-ingress     api.mycompany.com      /login      auth-service   80
```

📌 **Endpoint**: `http://api.mycompany.com/login`
This is what users hit from outside.

---

### 🔍 2. **Check Services (LoadBalancer or NodePort)**

```bash
kubectl get svc -A
```

Look for services with:

* `TYPE=LoadBalancer`: Has public IP (e.g., AWS/GCP)
* `TYPE=NodePort`: Accessible via node's external IP + port

#### Example:

```
NAME           TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)
user-service   LoadBalancer   10.0.1.10      13.235.101.5     80:31001/TCP
```

📌 **Endpoint**: `http://13.235.101.5`
Combine with API path (e.g., `/register`) = `http://13.235.101.5/register`

---

### 🔍 3. **Use `kubectl describe` to Inspect Services**

```bash
kubectl describe svc <service-name> -n <namespace>
```

It shows:

* Which ports are open
* What target pods it routes to

---

### 🔍 4. **Use Logs to Trace Called Endpoints**

```bash
kubectl logs <pod-name> -n <namespace>
```

Search for lines like:

```
POST /api/login
GET /api/products
```

📌 These are internal endpoints, exposed by your microservices.

---

### 🔍 5. **Look at Source Code / API Docs**

Check:

* `README.md`
* `swagger.yaml` or `/swagger-ui`
* Controllers/routes in code (Node.js, Python, Java, etc.)

---

## ✏️ PART 2: How to **CREATE** a New Endpoint (Expose a Service)

Suppose you built a service `order-service`. To expose it:

---

### ✅ Option 1: Expose with a Service + Ingress

1. **Create a Kubernetes Service (ClusterIP/NodePort/LoadBalancer)**

```yaml
apiVersion: v1
kind: Service
metadata:
  name: order-service
spec:
  selector:
    app: order
  ports:
    - port: 80
      targetPort: 8080
  type: LoadBalancer
```

2. **(Optional) Expose via Ingress**

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: order-ingress
spec:
  rules:
    - host: orders.mycompany.com
      http:
        paths:
          - path: /create
            pathType: Prefix
            backend:
              service:
                name: order-service
                port:
                  number: 80
```

📌 Now the endpoint is:

```http
http://orders.mycompany.com/create
```

---

## 🎯 Summary

| Task                           | Command / Action                         |
| ------------------------------ | ---------------------------------------- |
| List all endpoints via ingress | `kubectl get ingress -A`                 |
| Find exposed services          | `kubectl get svc -A`                     |
| View endpoint paths from logs  | `kubectl logs <pod>`                     |
| Describe routing details       | `kubectl describe svc <svc-name>`        |
| Add new endpoint (API)         | Update backend code (routes/controllers) |
| Expose it in cluster           | Create `Service` + `Ingress`             |

---

Would you like help inspecting your current services to find real endpoints?
If yes, run:

```bash
kubectl get ingress -A
kubectl get svc -A
```
