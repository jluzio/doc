#!/bin/bash

export INSTALLATION_NAME="<installation_name>"
export INSTALLATION_REGION="<installation_region>"
export SERVICES_ACCOUNT_IDENTIFIER=<services_account_identifier>
export AWS_SHARED_CREDENTIALS_FILE=~/.aws/$INSTALLATION_NAME/credentials
export AWS_CONFIG_FILE=~/.aws/$INSTALLATION_NAME/config

declare -A configs=(["dev"]="<runtime_dev>" ["stg"]="<runtime_stg>" ["prd"]="<runtime_prd>")
export RUNTIME_NAME=${1:-dev}
export RUNTIME_ACCOUNT_IDENTIFIER=${configs[$RUNTIME_NAME]}

#Select the right profile for AWS CLI
export AWS_PROFILE=baas-$INSTALLATION_NAME-$RUNTIME_NAME-k8s
