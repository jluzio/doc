#!/bin/bash
#http_proxy=http://localhost:8888
#https_proxy=$http_proxy

# Workaround for issue:
# Unable to connect to the server: Get "https://nbbdev-pksapi.nbbdev.com.bh:8443/oauth/token/.well-known/openid-configuration":
# x509: certificate relies on legacy Common Name field, use SANs or temporarily enable Common Name matching with GODEBUG=x509ignoreCN=0
export GODEBUG=x509ignoreCN=0
