#!/bin/bash

export AWS_PROFILE=baas-$INSTALLATION_NAME
aws ecr get-login-password \
  --region "${INSTALLATION_REGION}" | docker login --username AWS \
  --password-stdin "${SERVICES_ACCOUNT_IDENTIFIER}".dkr.ecr."${INSTALLATION_REGION}".amazonaws.com
