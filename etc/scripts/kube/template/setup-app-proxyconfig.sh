#!/bin/bash

target=${1-all}

if [ $target = "all" ]; then
  echo "sshuttle for $target"
  sshuttle --dns -r <user>@<jumpserver> -x <jumpserver> 0.0.0.0/0
else
  if [ $target = "api" ]; then
    # api-host
    ssh_tunnel=<bind_port>:<host>:<host_port>
  fi
  if [ $target = "dev" ]; then
    # dev.nbbdev.com.bh - 10.104.168.22
    ssh_tunnel=<bind_port>:<host>:<host_port>
  fi
  if [ $target = "test" ]; then
    # test.nbbdev.com.bh - 10.104.168.21
    ssh_tunnel=<bind_port>:<host>:<host_port>
  fi
  if [ $target = "uat" ]; then
    # uat.nbbdev.com.bh - 10.104.168.20
    ssh_tunnel=<bind_port>:<host>:<host_port>
  fi
  # ssh tunnel background process
  #ssh -fNL $ssh_tunnel sysadmin@nbbjumpserver
  # ssh tunnel background in shell
  echo "SSH tunnel for $target :: $ssh_tunnel"
  ssh -NnL $ssh_tunnel <user>@<jumpserver>
fi
