#!/bin/bash

#Create a directory for the installation
mkdir -p ~/.kube/$INSTALLATION_NAME
#Create a seperate kubeconfig for this installation
export KUBECONFIG=~/.kube/$INSTALLATION_NAME/config
#Generate the kubeconfig file
aws eks --region $INSTALLATION_REGION update-kubeconfig --name $INSTALLATION_NAME-$RUNTIME_NAME-$INSTALLATION_REGION
