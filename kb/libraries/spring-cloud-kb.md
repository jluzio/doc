# Issues

## Trying to detect if in Kubernetes on startup and having error
Might be detecting ~/.kube/config and trying to do a request to that server, specially if that config needs proxy or something extra to work properly

Workaround: rename config file or use KUBECONFIG environment to point to a directory that doesn't exist
```bash
export KUBECONFIG=/doesnt-exist/
```

## Service discovery for tests
~~~yaml
spring:
  cloud:
    discovery:
      client:
        simple:
          interfaces:
            some-service-id:
            - uri: http://localhost:8080
~~~