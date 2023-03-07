#!/bin/bash

sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo apt update
curl https://releases.rancher.com/install-docker/19.03.sh | sh
sudo systemctl enable docker
sudo usermod -aG docker $USER
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt update
sudo apt install -y kubectl=1.19.3-00
sudo apt-mark hold kubectl
wget https://github.com/rancher/rke/releases/download/v1.2.8/rke_linux-amd64
mv rke_linux-amd64 rke
sudo mv rke /usr/local/bin/
sudo chmod +x /usr/local/bin/rke