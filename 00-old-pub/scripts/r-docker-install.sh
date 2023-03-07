#!/bin/bash

sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo apt update
curl https://releases.rancher.com/install-docker/19.03.sh | sh
sudo systemctl enable docker
sudo usermod -aG docker $USER