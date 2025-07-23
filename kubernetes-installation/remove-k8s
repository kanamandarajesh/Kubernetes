## removing k8s

Your script successfully **removed Kubernetes and its related components** from the system. ✅ However, the **containerd** runtime still retains **leftover pods, mounts, and overlays** that were not completely cleaned up.

### Here's a summary of what the output shows:

---

### ✅ **What went well**

* `kubeadm reset` completed with warnings but did most cleanup.
* `kubelet`, `kubectl`, `kubeadm`, `kubernetes-cni`, `cri-tools` were successfully uninstalled.
* Kubernetes-related directories were deleted:
  `/etc/kubernetes`, `/var/lib/etcd`, `/var/lib/kubelet`, `/root/.kube`, etc.
* Container network interfaces (`cni0`, `flannel.1`, `tunl0`) were deleted.
* `containerd` was reset and restarted with new config using `SystemdCgroup = true`.

---

### ⚠️ **What's still left behind**

* **Mount points** and **overlay filesystems** from Kubernetes pods are still mounted:

  ```
  shm on /opt/containerd/state/io.containerd.grpc.v1.cri/sandboxes/...
  overlay on /opt/containerd/state/io.containerd.runtime.v2.task/k8s.io/...
  ```

  These are *leftover namespaces and volumes from pods* that were running under `containerd`.
  They weren't cleaned properly because `kubeadm reset` couldn’t stop them:

  > `rpc error: code = DeadlineExceeded desc = context deadline exceeded`

---

### 🧹 **Clean up manually (recommended)**

Run the following to clean the leftovers:

```bash
# Kill leftover containerd pods (be careful!)
sudo ctr -n k8s.io containers list
sudo ctr -n k8s.io tasks list
sudo ctr -n k8s.io tasks kill --all
sudo ctr -n k8s.io containers delete --all

# Or, brute-force way: unmount everything from Kubernetes
mount | grep containerd | awk '{print $3}' | xargs -r umount -lf

# Remove stale containerd state (optional if system reboot is planned)
rm -rf /opt/containerd/state
rm -rf /var/lib/containerd/io.containerd.runtime.v2.task/k8s.io
```

---

### 🧪 Verify after cleanup

```bash
# Check for remaining Kubernetes-related mounts
mount | grep containerd

# Disk usage again
df -h
```

---

### 💡 Final Note

If you're planning a **fresh Kubernetes reinstallation**, it's a good idea to **reboot the node after cleanup** to flush all network namespaces and leftover mounts.



```
#!/bin/bash
set -euo pipefail
set -x  # Debug mode

echo "🧨 Cleaning up Kubernetes installation..."

# 1. Reset kubeadm (ignore errors if already reset)
kubeadm reset -f || true

# 2. Stop and disable kubelet
systemctl stop kubelet || true
systemctl disable kubelet || true

# 3. Remove Kubernetes binaries (optional)
yum remove -y kubelet kubeadm kubectl kubernetes-cni || true

# 4. Remove Kubernetes configuration and state
rm -rf /etc/kubernetes \
       /var/lib/etcd \
       /var/lib/kubelet \
       /var/lib/cni \
       /etc/cni \
       /opt/cni \
       /root/.kube \
       ~/.kube

# 5. Delete CNI interfaces if present
ip link delete cni0 2>/dev/null || true
ip link delete flannel.1 2>/dev/null || true
ip link delete tunl0 2>/dev/null || true

# 6. Remove containerd config and reset it
systemctl stop containerd || true
rm -rf /etc/containerd /var/lib/containerd
mkdir -p /etc/containerd
containerd config default > /etc/containerd/config.toml
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
systemctl restart containerd
systemctl enable containerd

# 7. Remove Kubernetes repo file
rm -f /etc/yum.repos.d/kubernetes.repo

echo "✅ Kubernetes has been fully removed from this system."

```
