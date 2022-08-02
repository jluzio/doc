Kubernetes
==========

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

# Container Abstractions
- Pod: one or more containers running together on one node
  * Basic unit of deployment
- Controller: for creating/updating pods and other objects
  * types include: Deployment, ReplicaSet, StatefulSet, DaemonSet, Job, CronJob
- Service: network endpoint to connect to a pod
- Namespace: filtered group of objects in a cluster


# Commands
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
kubectl apply
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
