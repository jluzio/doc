
- Accessing other Docker containers from a container
At the moment, host.docker.internal doesn't resolve for services in other containers like Mysql, ActiveMQ, etc.
As a workaround, a mapping can be used to enable the same behavior.

https://stackoverflow.com/a/71056073/13181895
docker run -it --rm --add-host=bridge.docker:host-gateway alpine cat /etc/hosts

# docker-compose.yml
  my_app:
    image: ...
    extra_hosts:
      - "bridge.docker:host-gateway"
