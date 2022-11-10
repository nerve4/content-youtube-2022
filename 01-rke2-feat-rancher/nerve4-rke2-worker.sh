#!/bin/bash
# rke2 - (Worker) Node Installation

# Variables, DO NO~T FORGET TO FILL IT
SERVER_IP="192.168.1.60"
TOKEN="K10a3554734febf9640170918a013fb5176c95868de741e6b37df1bf7ab5d66f6fe::server:c364def31225fd1af2331bf7a461e932"

# Swap Off
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Run the installer
curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" sh -
# Enable the rke2-agent service
systemctl enable rke2-agent.service
# Configure the rke2-agent service¶
mkdir -p /etc/rancher/rke2/
echo "server: https://$SERVER_IP:9345" | sudo tee /etc/rancher/rke2/config.yaml
echo "token: $TOKEN" \ >> /etc/rancher/rke2/config.yaml
# Start the service
systemctl start rke2-agent.service

exit 127

