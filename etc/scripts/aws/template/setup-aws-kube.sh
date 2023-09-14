#!/bin/bash

script_dir="$( dirname "${BASH_SOURCE[0]}" )"

. $script_dir/setup-aws.sh $@
. $script_dir/setup-kube.sh $@

[[ "$2" == --gen || "$2" == -g ]] && { . $script_dir/setup-app-kubeconfig.sh $@; }
