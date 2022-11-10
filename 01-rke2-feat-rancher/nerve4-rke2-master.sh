#!/bin/bash

# Run the installer
curl -sfL https://get.rke2.io | sh -
# Enable the rke2-server service
systemctl enable rke2-server.service
# Start the service
systemctl start rke2-server.service

exit 127

