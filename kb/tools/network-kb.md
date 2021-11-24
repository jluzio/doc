# network-kb

- Go and legacy certificates
x509: certificate relies on legacy Common Name field, use SANs or temporarily enable Common Name matching with GODEBUG=x509ignoreCN=0
Set: GODEBUG=x509ignoreCN=0

More info:
https://golang.org/doc/go1.16#crypto/x509
The GODEBUG=x509ignoreCN=0 flag will be removed in Go 1.17. It enables the legacy behavior of treating the CommonName field on X.509 certificates as a host name when no Subject Alternative Names are present.

# VPN
- OpenVPN Connect (Proprietary):
working version (2021-11): 3.2.3

- OpenVPN GUI (Open source)
