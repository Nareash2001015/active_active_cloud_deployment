#!/bin/bash

# Run the kubectl command to get the IP address
ip_address=$(kubectl get svc -n ingress-nginx -o=jsonpath='{.items[0].status.loadBalancer.ingress[0].ip}')

# Add DNS records to /etc/hosts
if [ ! -z "$ip_address" ]; then
    echo "$ip_address       gateway.am.wso2.com" | sudo tee -a /etc/hosts
    echo "$ip_address       am.wso2.com" | sudo tee -a /etc/hosts
    echo "$ip_address       websub.am.wso2.com" | sudo tee -a /etc/hosts
    echo "$ip_address       websocket.am.wso2.com" | sudo tee -a /etc/hosts
    echo "DNS records added to /etc/hosts."
else
    echo "Failed to retrieve IP address from kubectl command."
fi