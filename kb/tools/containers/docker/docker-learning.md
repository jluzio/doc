# Playground
https://labs.play-with-docker.com/

# Concepts

## Container
* Don't include the OS Kernel (it isn't a full OS, "just an application")
* Run and CTRL-C: run the image with -it flags
~~~bash
docker container run -it _image_
~~~

## Image
* Docker build caches all instructions, so if a part changes all below it will be rebuilt
* Workdir is best practice for changing directories in build
* Commands in build shell might be chained in order to make only 1 layer (ex: apt-get update && apt-get install <packages> && ...), and it's best practice to do so

## Network
* Bridge/Docker0: default virtual network on which containers are created (which is different than host machine)
* Containers on bridge don't have DNS resolution by container name
* Creating a Network with Bridge driver allows DNS resolution by container name
### Multi-host
* Use --driver overlay (used on swarm)

## Persistent data
* Volume: persistent volume stored outside the container
* Bind mounts: map a host path to a container path
* Used in docker run with -v
  * volume_name:/path/container - volume mapping
  * /path/host:/path/container - bind mount mapping
  > **Note**:
  >
  > Can use $(pwd) or ${pwd} (Powershell)
  >
  > Windows might need 2 slashes //c/path/to/files or /$(pwd)

## VMs
To setup multiple VMs for Docker Swarm or K8s there are some options
- multipass.run: https://multipass.run/
- use play-with-docker (4 hours session)
  * Note: has a template (wrench icon) setup for Swarm

## Routing Mesh
- Routes ingress (incoming) packets for a Service to proper Task
- Spans all nodes in Swarm
- Load balances (stateless)
  * This works at OSI Layer 3 (TCP), not Layer 4 (DNS), so no multiple same ports on a node
  * Can be overcome with Nginx or HAProxy LB proxy or Docker Enterprise edition
- How it works?
  * Container-to-container in a Overlay network (uses VIP)
  * External traffic incoming to published ports (all nodes listen)

## Compose
- Compose is a tool for defining and running multi-container Docker applications.

## Stack
- Manage Docker stacks, similar concept of compose but for Swarm

## Secrets
- Easiest secure solution for storing secrets in Swarm
- Supports generic strings or binary content up to 500KB in size
- It's for Swarm, but docker compose does a workaround to use secrets

When you add a secret to the swarm, Docker sends the secret to the swarm manager over a mutual TLS connection.
The secret is stored in the Raft log, which is encrypted. The entire Raft log is replicated across the other managers,
ensuring the same high availability guarantees for secrets as for the rest of the swarm management data.
When you grant a newly-created or running service access to a secret, the decrypted secret is mounted into the container in an in-memory filesystem.
The location of the mount point within the container defaults to /run/secrets/<secret_name> in Linux containers, or C:\ProgramData\Docker\secrets in Windows containers.
You can also specify a custom location.

> Note: for compose, it's using a bind mount (volume)


## Healthchecks
- Docker engine will exec the command in the container: e.g. curl localhost
- Expects return: 0 = OK, 1 = Error
- States: starting, healthy, unhealthy
- Unhealthy services are replaced (Swarm), docker run doesn't act

### Options
Used in Dockerfile (*), docker run (health-*), docker compose (healthcheck), with different names
* cmd
* interval
* timeout
* start-period
* retries

## Sample structure for compose files
- docker-compose.yml: defaults
- docker-compose.override.yml: used by default with docker compose
- docker-compose.<id>.yml: compose specialization, can be used with the format `docker compose -f a.yml -f b.yml`
  * docker-compose.test.yml: example for CI builds using docker compose
  * docker-compose.prod.yml: example for Production deploys using docker stack,
  can be used with `docker compose -f a.yml -f b.yml config` to generate Stack deploy


## Docker Registry

### Docker Hub
- Most popular public image registry
- Has some lightweight image building

#### Automated builds (PRO feature)
- Can setup a Github or Bitbucket with Pro accounts
- Can verify changes in other repos to trigger builds (useful for when using FROM <another-image>)
- Can have triggers

### Private Registry
https://docs.docker.com/registry/
- Image: registry
- No auth/simple auth
- Can have storage cleanup via Garbage Collection
> https://docs.docker.com/registry/garbage-collection/
- Can enable cache using `registry-mirror` option
> https://docs.docker.com/registry/recipes/mirror/
- Enable TLS
> https://training.play-with-docker.com/linux-registry-part2/
- Note: works the same with Swarm. Because of Routing mesh all nodes can see the new registry service

### Third party Image Registries
- Quay.io is a popular choice
- AWS, Azure or Google Cloud have their own registries



# Commands

## Container
* Run container
  ~~~bash
  docker container run
  ~~~
  > *-p/--publish host_port:container_port*: publish port

  > *--name name*: set name container

  > *-d/--detach*: detach

  > *command*: execute command instead of container entrypoint command

  > *-v/--volume name:path*: set volume


* Stop/remove container
  ~~~bash
  docker container stop/rm container_id
  ~~~

* Start container
  ~~~bash
  docker container start container_id
  ~~~

  > *-ai*: attach + interactive tty

* Execute command on container
  ~~~bash
  docker container exec container_id command
  ~~~

  > *-it*: interactive + tty

* Inspect container metadata
  ~~~bash
  docker container inspect container_id
  ~~~

  > *--format {go-template-selector}*: output result of go template selector
  >
  > example:  `--format "{{.NetworkSettings.IPAddress}}"`

* List containers
  ~~~bash
  docker container ps
  ~~~

  > *-a/--all*: all containers (even stopped)

* Top command for processes on container
  ~~~bash
  docker container top
  ~~~

* See ports on container
  ~~~bash
  docker container port
  ~~~


## Network
* Show networks:
  ~~~bash
  docker network ls
  ~~~

* Inspect network:
  ~~~bash
  docker network inspect
  ~~~

* Create network:
  ~~~bash
  docker network create --driver
  ~~~

* Attach a network to a container:
  ~~~bash
  docker network connect
  ~~~

* Detach a network to a container:
  ~~~bash
  docker network disconnect
  ~~~

## Account
* Login
  ~~~bash
  docker login
  ~~~

* Logout
  ~~~bash
  docker logout
  ~~~

## Image
* Show image layer history:
  ~~~bash
  docker image history
  ~~~

* Inspect image:
  ~~~bash
  docker image inspect
  ~~~

* Tag image:
  ~~~bash
  docker image tag imageId tag
  ~~~

* Inspect image:
  ~~~bash
  docker image push tag
  ~~~

* Build image:
  ~~~bash
  docker image build (-f _file_) _dir_
  ~~~

* Prune:
  * `docker image prune`: clean up just "dangling" images
  * `docker image prune -a`: removes all images you're not using. Use docker system df to see space usage.
  * (!!AVOID!!) `docker system prune`: clean up everything (!!AVOID!!)


## Volume
* Create:
  ~~~bash
  docker volume create
  ~~~


## Compose
* Up:
  ~~~bash
  docker compose up
  ~~~

  > Can build image if not present (does not rebuild if present)

* Down:
  ~~~bash
  docker compose down
  ~~~

  > *-v/--volume*: delete associated volumes

  > *--rmi (all|local)*: remove images reference by services. local removes only local without custom tags (image: _custom_name_)

* Build:
  ~~~bash
  docker compose build
  ~~~

## Swarm - Container orchestration
* Init:
~~~bash
docker swarm init
~~~

* Leave:
~~~bash
docker swarm leave [--force]
~~~

* Node ls:
~~~bash
docker node ls
~~~

### Service ("replacement" of docker run for swarm, "aka deployment" in Kubernetes)
* General params:
  * --detach true|false: if the service command waits to be finished

* Create:
~~~bash
docker service create
~~~
Example:
~~~bash
docker service create --name ping --replicas=3 alpine ping 8.8.8.8
~~~

* List services:
~~~bash
docker service ls
~~~

* List tasks:
~~~bash
docker service ps
~~~

* Scale:
~~~bash
docker service scale
~~~

* Update:
~~~bash
docker service update
~~~
  * --replicas=[N]
    * also: `docker service scale`
  * --image _new_image_
  * ...
  * --force: completely replaces tasks, can rebalance tasks

#### Multiple nodes
* Init with advertise:
~~~bash
docker swarm init --advertise-addr=_IP_
~~~

* Join:
Use command shown in init.
~~~bash
docker swarm join
~~~
Re-check join command:
~~~bash
docker swarm join-token manager|worker
~~~

* Update node to being a manager:
~~~bash
docker node update --role manager _node_
~~~


## Stack (compose for Swarm)
* Deploy (and re-deploy)
~~~bash
docker stack -c <stack-file.yml> <stack-name>
~~~


## Secrets
* Create
~~~bash
docker secret create
~~~
With file or key-value


## Registry
* Run registry image
~~~bash
~~~

* Run registry image
~~~bash
docker container run --name registry -d -p 5000:5000 registry
~~~

* Re-tag image to local registry
~~~bash
docker tag hello-world 127.0.0.1/hello-world
docker push 127.0.0.1/hello-world
~~~

* Remove image and pull from local registry
~~~bash
docker image rm hello-world
docker image rm 127.0.0.1/hello-world
docker pull 127.0.0.1/hello-world
~~~

* Re-create registry using a bind mount to see stored data
~~~bash
docker container run --name registry -d -p 5000:5000 -v $(pwd)/registry-data:/var/lib/registry registry
~~~
