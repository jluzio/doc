# Apps

# Telepresence
https://www.telepresence.io/
https://www.telepresence.io/docs/latest/quick-start/
bb_telepresence_guide.pdf

# k9s
https://k9scli.io/
https://github.com/derailed/k9s
## plugins
https://github.com/derailed/k9s/tree/master/plugins
## GO version compatible with legacy certificates (error: x509: certificate relies on legacy Common Name field)
https://github.com/derailed/k9s/releases/tag/v0.24.15
## increase max lines show of logs
~~~yaml
k9s.logger.tail: 2000
~~~

# kube-prompt
https://github.com/c-bata/kube-prompt

# stern
https://github.com/wercker/stern

# Lens
https://k8slens.dev/

## Latest free version 5.5.4
choco install -y lens --version=5.5.4

## GO version compatible with legacy certificates (error: x509: certificate relies on legacy Common Name field)
- Download compatible Kubernetes client:
```bash
curl -LO "https://dl.k8s.io/release/<version>/bin/windows/amd64/kubectl.exe"
```
```bash
# version v1.17.17
curl -LO "https://dl.k8s.io/release/v1.17.17/bin/windows/amd64/kubectl.exe"
```
- Turn off `Download kubectl binaries matching the Kubernetes cluster version`
- Set `Path to kubectl binary` with downloaded version
