#!/bin/bash
mkdir -p $(dirname $KUBECONFIG)

# create kubeconfig

# example tkgi/pks
#PASS="<pass>"
#echo $PASS | tkgi login -a <tkgi_or_pks_api_server> -u <service_user> -k
#echo $PASS | tkgi get-credentials ${1:dev}
