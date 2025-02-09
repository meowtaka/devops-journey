#init control-plane and check the error details if exits
sudo kubeadm init --config kubeadm-config.yaml --v=5
containerd --version #cehck version of  containerd
#installation start if the containerd not exits
sudo dnf install -y ca-certificates curl gnupg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo dnf update
sudo dn install -y containerd.io
sudo dnf install -y containerd.io
sudo containerd config default | sudo tee /etc/containerd/config.toml
sudo systemctl restart containerd.service
#end installation

#check info about cri
sudo crictl --runtime-endpoint unix:///var/run/containerd/containerd.sock info
#init project control-plane kubeadm
sudo kubeadm init --cri-socket unix:///var/run/containerd/containerd.sock --v=5

#after successfully install the control-plane, the output should be like these in below
: <<'END'
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.1.7:6443 --token xhc8hr.yb1ci6m32surgcy2 \
        --discovery-token-ca-cert-hash sha256:a6adfc4fadf0984479eaebbbb4309157786b63de6238112b6eea87625ea344cf
END

: <<'#WARNING'
WARNING - PLEASE DISABLE SWAP RAM LIKE ZRAM OR ELSE
BECAUSE WHEN USING KUBEADM, THE SWAP US BE DISABLED
CHECK disable-swap.sh file in the same directory
if disable the swap at this step, the updatethe kubelet configuration

  sudo nano /etc/default/kubelet

  #add this

  KUBELET_EXTRA_ARGS="--fail-swap-on=false"

then restart the kubelete using
  sudo systemctl restart kubelet

then retry join kubeadm
#WARNING
