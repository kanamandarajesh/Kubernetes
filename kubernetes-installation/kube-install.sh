#!/bin/bash
set -euo pipefail
set -x  # Debug: print each command

# 1. Set hostname
sudo hostnamectl set-hostname master-node

# 2. Disable swap (required for kubelet)
sudo swapoff -a
sudo sed -i '/swap/d' /etc/fstab

# 3. Disable SELinux
sudo setenforce 0 || true
sudo sed -i 's/^SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config

# 4. Disable firewall (or configure ports properly)
sudo systemctl disable --now firewalld || true

# 5. Kernel modules and sysctl
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sudo sysctl --system

# 6. Install containerd
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y containerd.io

sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd

# 7. Remove old Kubernetes repo if exists
sudo rm -f /etc/yum.repos.d/kubernetes.repo

# 8. Add working Kubernetes repo for CentOS Stream 9
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/repodata/repomd.xml.key
EOF

# 9. Install Kubernetes components
sudo yum install -y kubelet kubeadm kubectl
sudo systemctl enable --now kubelet

# 10. Initialize Kubernetes master node
sudo kubeadm init --pod-network-cidr=192.168.0.0/16

# 11. Set up kubeconfig for root user
mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# 12. Deploy Calico CNI for networking
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/calico.yaml

echo "✅ Kubernetes master setup completed!"

