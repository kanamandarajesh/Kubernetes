To install Kubernetes successfully (especially in interviews or real-world deployment), it's important to **clearly specify your system details** so the setup and troubleshooting can be accurate.

Here’s what kind of **system information** you should provide (or check for yourself):

---

### ✅ Minimum System Info to Provide

| 🔧 Category           | 📋 Detail Example                                        |
| --------------------- | -------------------------------------------------------- |
| **OS version**        | CentOS 7.9 / CentOS 8.6                                  |
| **Architecture**      | `x86_64`                                                 |
| **Kernel version**    | `uname -r` → `3.10.0-1160.el7.x86_64`                    |
| **Memory (RAM)**      | At least 2GB (4GB+ recommended)                          |
| **CPU cores**         | At least 2 vCPUs                                         |
| **IP address**        | Static IP preferred                                      |
| **Hostname**          | `master-node` or `worker-node`                           |
| **Swap status**       | `swapoff -a` and disabled in `/etc/fstab`                |
| **Firewall status**   | `firewalld` disabled or proper ports opened              |
| **SELinux status**    | Disabled or set to permissive mode                       |
| **Container Runtime** | `containerd` or `Docker` (if using Docker, version info) |
| **Installed tools**   | `kubelet`, `kubeadm`, `kubectl` version                  |

---

### 🔍 Sample Commands to Collect System Info

```bash
# OS info
cat /etc/os-release

# Kernel version
uname -r

# CPU and Memory
lscpu
free -h

# IP address
ip a

# Hostname
hostnamectl

# Firewall status
sudo systemctl status firewalld

# SELinux status
sestatus

# Docker or containerd version
docker --version
containerd --version

# kubeadm version
kubeadm version
```

---

### 📌 Optional (if troubleshooting)

* DNS resolvers: Check `/etc/resolv.conf`
* NTP or clock sync: `timedatectl status`
* Proxy settings if you're behind a proxy
* `/etc/hosts` content if you're using custom hostname resolution

---

Would you like a script to collect all this system info automatically and save it to a file?
