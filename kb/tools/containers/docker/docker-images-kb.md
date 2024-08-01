# SysOps
## network-multitool
Alpine based multi-arch multi-tool for container network troubleshooting
https://hub.docker.com/r/wbitt/network-multitool
docker run -it --rm --name net-tools wbitt/network-multitool bash

# Dev
https://hub.docker.com/r/confluentinc/cp-kafka


# Troubleshooting
- OpenSearch config
~~~md
https://hub.docker.com/r/opensearchproject/opensearch

ISSUE with vm.max_map_count
https://stackoverflow.com/questions/69214301/using-docker-desktop-for-windows-how-can-sysctl-parameters-be-configured-to-sur

Session only workaround:
- Docker Desktop: wsl -d docker-desktop sh -c "sysctl -w vm.max_map_count=262144"
- Rancher Desktop: wsl -d rancher-desktop sh -c "sysctl -w vm.max_map_count=262144"
~~~
