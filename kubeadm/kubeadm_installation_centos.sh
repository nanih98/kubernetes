#! /bin/bash
#Preinstallation, docker and kubernetes services installation for centos instance.
yum -y update && yum -y update && yum -y install make gcc kernel-devela kernel-header net-tools vim
#Disable selinux 
setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
#Disable swap, it’s required for kubernetes
swapoff -a
#Install necessary packages for docker
yum install -y yum-utils device-mapper-persistent-data lvm2
#Add repo
yum-config-manager \
--add-repo \
https://download.docker.com/linux/centos/docker-ce.repo
#Install docker
yum install -y docker-ce docker-ce-cli containerd.io docker-compose
#Enable the service and start it. 
systemctl start docker && systemctl enable docker
#Allow docker command only for root 
usermod -aG docker $(whoami)
#Add kubernetes repos
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
        https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
#Install kubernetes
yum install -y kubelet kubeadm kubectl
#Enable kubernetes service and start it
systemctl start kubelet && systemctl enable kubelet
