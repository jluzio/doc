#!/bin/bash
script_dir="$( dirname "${BASH_SOURCE[0]}" )"

export KUBECONFIG=~/.kube/app/config

source $script_dir/setup-app-proxy.sh
