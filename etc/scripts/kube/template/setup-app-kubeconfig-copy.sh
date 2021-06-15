#!/bin/bash

source_cfg=<source_home>/app/config
output_dir=<target_home>/.kube/app
output_cfg=$output_dir/config

# cp / scp / rsync / etc
cp $source_cfg $output_cfg

# useful for ssh tunnels, while mantaining the original host name
sed -i 's/<host>/<host_alias>/g' $output_cfg
