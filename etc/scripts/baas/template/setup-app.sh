#!/bin/bash

script_dir="$( dirname "${BASH_SOURCE[0]}" )"

. $script_dir/setup-proxy.sh
. $script_dir/setup-aws-kube.sh $@
