### **Ingress Overview**

In Kubernetes, **Ingress** is a powerful resource that manages HTTP and HTTPS access to services within a Kubernetes cluster. It provides HTTP routing, SSL/TLS termination, load balancing, and name-based virtual hosting for services. By defining Ingress resources, you can expose your services to the external world and configure how traffic is routed to the appropriate services.

An **Ingress Controller** is required to implement the rules defined in the Ingress resource. It is responsible for managing traffic routing as per the Ingress specifications.

### **Key Features of Ingress:**
- **Path-based routing**: Direct traffic to different services based on the URL path.
- **Host-based routing**: Route traffic to different services based on the hostname (e.g., `example.com` vs. `api.example.com`).
- **SSL/TLS termination**: Manage SSL certificates and terminate HTTPS traffic, forwarding requests to the backend over HTTP.
- **Load balancing**: Distribute incoming traffic among the backend services.
- **Rewrite and redirect rules**: Ingress allows you to rewrite URLs or redirect traffic.

### **Components Involved:**
1. **Ingress Resource**: Defines the routing rules (e.g., URL paths and backend services).
2. **Ingress Controller**: A controller that watches the Ingress resources and configures the HTTP routing for the defined rules. Common controllers are Nginx Ingress Controller, Traefik, and HAProxy.

---

### **Ingress Resource Example:**

Here’s a simple example of an **Ingress** resource in Kubernetes.

#### 1. **Example 1: Simple Ingress with Path-based Routing**

Let’s assume you have two services (`service-a` and `service-b`), and you want to route traffic to these services based on the URL path:

- `http://<ingress_host>/app` should route to `service-a`.
- `http://<ingress_host>/api` should route to `service-b`.

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: example.com   # Replace with your domain or external IP
    http:
      paths:
      - path: /app
        pathType: Prefix
        backend:
          service:
            name: service-a
            port:
              number: 80
      - path: /api
        pathType: Prefix
        backend:
          service:
            name: service-b
            port:
              number: 80
```

#### **Explanation:**
- `host: example.com`: This rule applies when the incoming request is made to `example.com`. If you're running in a local cluster, this could be your cluster's external IP.
- `path: /app`: Routes requests with the path `/app` to the `service-a` service.
- `path: /api`: Routes requests with the path `/api` to the `service-b` service.
- `nginx.ingress.kubernetes.io/rewrite-target: /`: This annotation ensures that the path `/app` is rewritten to `/` when it’s passed to `service-a`.

#### 2. **Example 2: Host-based Routing**

If you want to route based on different hosts (like `app.example.com` and `api.example.com`), you can define an Ingress with multiple hosts:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: host-based-ingress
spec:
  rules:
  - host: app.example.com  # Replace with your desired host for this service
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: service-a
            port:
              number: 80
  - host: api.example.com  # Replace with another desired host for this service
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: service-b
            port:
              number: 80
```

#### **Explanation:**
- This rule defines two different services, `service-a` and `service-b`, based on the host requested by the client. 
- Requests to `app.example.com` are routed to `service-a`, and requests to `api.example.com` are routed to `service-b`.

#### 3. **Example 3: SSL Termination with Ingress**

You can also use Ingress to manage SSL certificates and terminate HTTPS traffic. Here’s an example of an Ingress resource that uses SSL/TLS:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ssl-ingress
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
spec:
  tls:
  - hosts:
    - example.com
    secretName: example-tls-secret  # Secret holding the SSL certificate
  rules:
  - host: example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: service-a
            port:
              number: 80
```

#### **Explanation:**
- `tls` section specifies the SSL certificate secret (`example-tls-secret`) to be used for `example.com`.
- All incoming HTTPS traffic to `example.com` will be terminated by the Ingress controller, and the traffic will then be forwarded to `service-a` over HTTP.

---

### **Setting up an Ingress Controller:**

To make the Ingress resource work, you need to have an **Ingress Controller** running in your Kubernetes cluster. Some popular Ingress Controllers are:

1. **Nginx Ingress Controller**: One of the most commonly used Ingress Controllers.
   
   To install it via Helm:
   ```bash
   helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx
   ```

2. **Traefik**: Another popular Ingress Controller with automatic HTTPS features.
   
   To install it via Helm:
   ```bash
   helm install traefik traefik/traefik --namespace kube-system
   ```

3. **HAProxy**: Known for high performance and reliability.
   
   To install it via Helm:
   ```bash
   helm install haproxy-ingress haproxytech/kubernetes-ingress --namespace ingress-controller
   ```

### **How Ingress Works:**
1. You define an **Ingress resource** with routing rules, specifying which services should receive traffic based on the request URL or host.
2. An **Ingress Controller** monitors the Ingress resources and configures itself to route traffic accordingly. For example, the NGINX Ingress Controller will create NGINX configurations based on your Ingress rules to route the traffic.
3. The **Ingress Controller** can also manage SSL certificates, providing TLS termination and routing secure traffic (HTTPS) to your services.

---

### **Summary of Key Concepts:**

- **Ingress Resource**: Defines how HTTP/HTTPS traffic should be routed to different services based on URL paths or hostnames.
- **Ingress Controller**: A component that watches for Ingress resources and handles traffic routing based on the rules.
- **TLS Termination**: Ingress can manage SSL certificates and terminate HTTPS traffic.
- **Path-based & Host-based Routing**: You can route traffic based on URL paths or domains.
- **Rewrite and Redirect Rules**: You can rewrite URLs or redirect traffic to different paths or services.

---

### **Conclusion:**

Ingress is a powerful resource in Kubernetes that provides flexible traffic routing for HTTP and HTTPS traffic. It can be used for host-based or path-based routing, SSL termination, and other advanced routing capabilities. To use Ingress, you must also deploy an Ingress Controller in your cluster.

