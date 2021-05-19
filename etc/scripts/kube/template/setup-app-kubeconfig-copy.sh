#!/bin/bash

output_dir=<target_home>/.kube/app
output_cfg=$output_dir/config

# cp / scp / rsync / etc
cp ~/.kube/app/config $output_cfg

# useful for ssh tunnels, while mantaining the original host name
sed -i 's/<host>/<host_alias>/' $output_cfg
