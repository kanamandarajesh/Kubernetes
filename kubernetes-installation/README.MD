## ✅ Step-by-step Process for Run Join Command on Worker

### 🖥 2. Fix hostname resolution warning (optional, but good practice):

Since `hostname "worker-node" could not be reached`, add it to your `/etc/hosts` file:

```bash
sudo nano /etc/hosts
```

Add this line:

```
<worker-node-IP>    worker-node
```

Example:

```
192.168.199.130     worker-node
```

> Replace the IP with the **actual IP address** of the worker node.

---

### 🚀 3. Run the join command again

Now, go back to the **master node**, get the join command again (if expired):

```bash
sudo kubeadm token create --print-join-command
```

Copy and paste it on the worker node:

```bash
sudo kubeadm join <master-ip>:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
```

---

## 🎉 Done!

To verify:

* On the **master node**:

```bash
kubectl get nodes
```

You should now see your **worker node in Ready state**.
