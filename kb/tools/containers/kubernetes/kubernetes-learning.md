Kubernetes
==========
https://kubernetes.io/docs/

# Basic Terms
- Kubernetes (aka: k8s): orchestration system
- kubectl: CLI to control Kubernetes
- kubelet: K8s agent running on nodes
- Control Plane: set of containers that manage the cluster
  * Sometimes called master
  * Includes API server, scheduler, control manager, etcd (key-value storage), DNS (e.g. CoreDNS), etc.
- Node: single server in the cluster
  * Includes: kubelet, kube-proxy


# Install
- Docker Desktop: enable settings
- Rancher Desktop
- MiniKube
- Linux OS: MicroK8s
- etc

## Browser
- https://labs.play-with-k8s.com/
- https://killercoda.com/playgrounds/scenario/kubernetes


# Container Abstractions
- Pod: one or more containers running together on one node
  * Basic unit of deployment
- Controller: for creating/updating pods and other objects
  * types include: Deployment, ReplicaSet, StatefulSet, DaemonSet, Job, CronJob
- Service: network endpoint to connect to a pod
- Namespace: filtered group of objects in a cluster

## Service
Service is a stable address for pods, if we need to connect to a pod we need a service.
CoreDNS allows us to resolve services by name.

Types:
- ClusterIP (default)
  * Single, internal virtual IP allocated
  * Only reachable within cluster
- NodePort
  * High port allocated on each node
  * Port is open on every's node IP
  * Anyone can connect (if they can reach node)
- LoadBalancer
  * Controls a LB endpoint controller to the cluster
  * Only available when infra provider gives you a LB
  * Creates a NodePort+ClusterIP service, tells LB to send to NodePort
- ExternalName
  * Adds CNAME DNS record to CoreDNS only
  * Not used for pods, but for giving pods a DNS name to use for something outside Kubernetes
- Ingress
  * Is an API object that provides routing rules to manage external users' access to the services in a Kubernetes cluster, typically via HTTPS/HTTP

> Note: on expose commands, ClusterIP, NodePort and LoadBalancer are additive, creating a service also creates the other types above it
> e.g. NodePort also creates ClusterIP

## Service DNS
- Provided by CoreDNS (by default)
- DNS based service discovery
- Services have a FQDN of: <service>.<namespace>.svc.cluster.local

## ConfigMap
External configuration files.

## Secrets
Secure external configuration, using base64.


# Debug running pod
https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/

## Using ephemeral containers
https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/#ephemeral-container
https://loft.sh/blog/using-kubernetes-ephemeral-containers-for-troubleshooting/
Example of distroless image:
~~~bash
kubectl run ephemeral-demo --image=k8s.gcr.io/pause:3.1 --restart=Never
~~~

Create a ephemeral container with access to target pod resources
~~~bash
kubectl debug -it ephemeral-demo --image=busybox:1.28 --target=ephemeral-demo
~~~
~~~bash
kubectl debug -it ephemeral-demo --image=busybox:1.28 --copy-to=debug_pod_name --share-processes
~~~

When creating a debugging session on a node, keep in mind that:
- kubectl debug automatically generates the name of the new Pod based on the name of the Node.
- The container runs in the host IPC, Network, and PID namespaces.
- The root filesystem of the Node will be mounted at /host.


# Dry-run
- commands have a `dry-run` option
- can be client (not sending data to server), or server (sending to server but not applied)
- can be used with `-o yaml` to generate the yaml manifest file
- `kubectl diff` can generate the differences of the manifest


# Yaml Specs
https://kubernetes.io/docs/reference/#api-reference
https://kubernetes.io/docs/reference/kubernetes-api/
OpenAPI spec for 1.24 (link in reference page)
https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/

The base definition includes kind (resource type, from api-resources), apiVersion (from api-versions), metadata with name and spec depending on kind.
~~~yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  _deployment_spec_
~~~

Besides OpenAPI spec, details can be retrieved by explain:
~~~bash
kubectl explain services
~~~
~~~bash
kubectl explain services --recursive
~~~

Examples for a subkey of kind:
~~~bash
kubectl explain services.spec
~~~
~~~bash
kubectl explain services.spec.type
~~~


# Labels and Annotations
## Labels
- stored in metadata on YAML
- simple list of key-value for identifying a resource to be able to select it
- recommended labels: https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/
  * app.kubernetes.io/name: The name of the application
  * app.kubernetes.io/instance: A unique name identifying the instance of an application
  * app.kubernetes.io/version: The current version of the application (e.g., a semantic version, revision hash, etc.)
  * app.kubernetes.io/component: The component within the architecture
  * app.kubernetes.io/part-of: The name of a higher level application this one is part of
  * app.kubernetes.io/managed-by: The tool being used to manage the operation of an application
  * app.kubernetes.io/created-by: The controller/user who created this resource
## Annotations
- for more complex data which can be used as configuration for
## Label selectors
https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
- can be used on commands to filter data
- can be used on manifests (deployments, services) to know which objects they are related (e.g.: pods)
- taints and tolerations also control node placement (https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)

Example for manifest selectors:
~~~yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  # Unique key of the Deployment instance
  name: deployment-example
spec:
  # 3 Pods should exist at all times.
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        # Apply this label to pods and default
        # the Deployment label selector to this value
        app: nginx
    spec:
      containers:
      - name: nginx
        # Run this image
        image: nginx:1.14
~~~


# Volumes
- Volumes
  * tied to lifecycle of a pod
  * all containers in a pod can share them
- PersistentVolumes
  * created at cluster level
  * separates storage config from pod using it
  * multiple pods can share them
- CSI plugins are the new way to connect to storage

## Local Volumes  
Options:
 - hostPath
 - local
Examples:
- https://kubernetes.io/docs/tutorials/stateful-application/mysql-wordpress-persistent-volume/  

https://kubernetes.io/blog/2019/04/04/kubernetes-1.14-local-persistent-volumes-ga/  
Note: For local machines, local volume replaced hostPath as the preferred method.

### What is a Local Persistent Volume?

A local persistent volume represents a local disk directly-attached to a single Kubernetes Node.

Kubernetes provides a powerful volume plugin system that enables Kubernetes workloads to use a wide variety of block and file storage to persist data. Most of these plugins enable remote storage -- these remote storage systems persist data independent of the Kubernetes node where the data originated. Remote storage usually can not offer the consistent high performance guarantees of local directly-attached storage. With the Local Persistent Volume plugin, Kubernetes workloads can now consume high performance local storage using the same volume APIs that app developers have become accustomed to.

### How is it different from a HostPath Volume?
To better understand the benefits of a Local Persistent Volume, it is useful to compare it to a HostPath volume. HostPath volumes mount a file or directory from the host node’s filesystem into a Pod. Similarly a Local Persistent Volume mounts a local disk or partition into a Pod.

The biggest difference is that the Kubernetes scheduler understands which node a Local Persistent Volume belongs to. With HostPath volumes, a pod referencing a HostPath volume may be moved by the scheduler to a different node resulting in data loss. But with Local Persistent Volumes, the Kubernetes scheduler ensures that a pod using a Local Persistent Volume is always scheduled to the same node.

While HostPath volumes may be referenced via a Persistent Volume Claim (PVC) or directly inline in a pod definition, Local Persistent Volumes can only be referenced via a PVC. This provides additional security benefits since Persistent Volume objects are managed by the administrator, preventing Pods from being able to access any path on the host.

Additional benefits include support for formatting of block devices during mount, and volume ownership using fsGroup.

# Ingress
- https://kubernetes.io/docs/concepts/services-networking/ingress/
- https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/

- https://doc.traefik.io/traefik/v2.0/providers/kubernetes-ingress/
- https://doc.traefik.io/traefik/v2.0/user-guides/crd-acme/
- https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/

# CRDs and the Operator pattern
TODO: check and try operators
- https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/
- https://kubernetes.io/docs/concepts/extend-kubernetes/operator/
- https://operatorhub.io/
- https://github.com/operator-framework/awesome-operators (obsolete)

# Higher deployment abstrations
- Helm
- With Docker
  - Compose on Kubernetes (docker compose for stack using Kubernetes orchestrator)
  - docker app
- Templating
  - Helm
  - Kustomize (natively built into kubectl or standalone)
    - commands:
      - kubetcl apply -k
      - kustomize

# Kubernetes Dashboard
- Default GUI: github.com/kubernetes/dashboard
- beware of security

# Namespaces and Context
- Namespaces
  -  Virtual clusters
  - It's a label system, which is used by most commands to filter by context
- Clusters
  - ways to connect with different users or to different clusters

# Related projects
- Knative: serverless workloads on Kubernetes
- k3s: mini, simple Kubernetes
- k3OS: minimal OS for k3s
- Service Mesh: new layer for better control, security, monitoring, etc

# Automation
- Jenkins (maybe is decaying in usage due to complexity)
- Gitlabs CI
- Others

# Commands
- dry-run and output to yaml: use any command with --dry-run -o yaml to generate the yaml without applying to Kubernetes
Example:
~~~bash
kubectl create deployment nginx --image=nginx --dry-run -o yaml
~~~

- run: create pod
~~~bash
kubectl run
~~~

- create: create resources
~~~bash
kubectl create
~~~

- apply: create/update resources
~~~bash
kubectl apply -f _file_or_directory_
~~~

- delete: delete resources
~~~bash
kubectl delete
~~~

- get: get resources
~~~bash
kubectl get pods|deploy|all|...
~~~

- scale: scaling replicasets
~~~bash
kubectl scale deployment _name_ --replicas=N
~~~
~~~bash
kubectl scale deploy/_name_ --replicas=N
~~~
> deployment = deploy = deployments

- describe: describe resource
~~~bash
kubectl describe deploy _deploy-name_
~~~

- logs
Example: get logs for all pods in deployment
~~~bash
kubectl logs deploy/_deploy-name_
~~~

Example: get logs for all pods with label app=_deploy_name_ (which is all pods in deployment in this scenario)
~~~bash
kubectl logs -l app=_deploy-name_
~~~

- expose: creates a service for existing pods
~~~bash
kubectl expose
~~~

- api-resources: list api resources
~~~bash
kubectl api-resources
~~~

- api-version: list api resource versions
~~~bash
kubectl api-versions
~~~

- diff: see manifest changes
Example:
~~~bash
kubectl diff -f file.yml
~~~
