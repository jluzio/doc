# Direct IPs/SSH tunnels
May require to add tunneled hosts to system hosts.

E.g.
- if the direct ip is known
# kube direct
<direct-ip> <kube-api-host>
<direct-ip> <kube-context-host>

- if using tunnel
# kube ssh tunnel
127.0.0.1 <kube-api-host>
127.0.0.1 <kube-context-host>

