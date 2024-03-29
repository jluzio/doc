## References
https://kubernetes.io/docs/reference/kubectl/cheatsheet/
https://unofficial-kubernetes.readthedocs.io/en/latest/

## Cluster Env
kubectl config get-contexts

## Set rename context
kubectl config rename-context <old-context> <new-context>

## Set default namespace for context
kubectl config set-context --current --namespace=<insert-namespace-name-here>
- Validate it
kubectl config view --minify | grep namespace:

Otherwise, commands will have to use "-n <ns>"

## kubectl debug
https://github.com/aylei/kubectl-debug#quick-start

## Registry
If the registry has ExternalIP, it should show registered services by visiting http://<REGISTRY_HOST>:<REGISTRY_PORT>

## Pod env
kubectl exec POD env


## get
kubectl get <type1>[,<type2>,...,<typeN>]
kubectl get pods
kubectl get pods,svc,deploy


## Pods / Logs
kubectl get pods
kubectl logs -f POD --tail=1000
kubectl logs -f --since=10m <pod>
kubectl logs -f dbs-payments-paymentutilsservice-845968dd55-9bnr8 --tail=1000


## App env
kubectl get deploy
kubectl edit deploy <app>


## Remote Debug:
ssh -L <port>:localhost:<port> joao.l@nbbjumpserver
ex:
ssh -L 5005:localhost:5005 joao.l@nbbjumpserver

kubectl port-forward <pod> <port>:5005
kubectl port-forward $pod 5007:5005


## Kubernetes local config
- create .kube/config in local machine
export KUBECONFIG=~/.kube/<cfg>/config
<generate config into $KUBECONFIG>
- OR -
mkdir -p $(dirname $KUBECONFIG) && rsync -r <user>@<jumpserver>:.kube/config $KUBECONFIG


## Kubernetes on Jump server using sshuttle
- sshuttle - transparent proxy meets vpn meets ssh
https://github.com/sshuttle/sshuttle
https://sshuttle.readthedocs.io/en/stable/overview.html
sshuttle --dns -r <user>@<jumpserver> -x <jumpserver> 0.0.0.0/0

- kubectl with selected KUBECONFIG
export KUBECONFIG=~/.kube/<cfg>/config
kubectl get pods


## Kubernetes on Jump server using ssh port forward
- ssh port forward
ssh -Nn -D :<tunnel_port> <user>@<jumpserver>

- kubectl with selected KUBECONFIG
export KUBECONFIG=~/.kube/<cfg>/config
export http_proxy=socks5://localhost:<tunnel_port>
export https_proxy=$https_proxy
kubectl get pods


## Pivotal TKGI/PKS cli
(tkgi: newer, pks: maintenance mode?)
https://docs.pivotal.io/tkgi/1-10/installing-cli.html
tkgi:
https://network.pivotal.io/products/pivotal-container-service/#/releases/863377/file_groups/3393
pks:
https://network.pivotal.io/products/pivotal-container-service/#/releases/863377/file_groups/3392


export KUBECONFIG=~/.kube/<cfg>/config
echo $pass | tkgi login -a <server> -u <user> -k
echo "<pass>" | pks get-credentials <env>


### Activate debug in infra
helm files:
      - identityintegrationservice:
          database:
            existingSecret: oracle-secret-identity
            existingSecretKey: key
          ingress:
            enabled: false
          service:
            type: LoadBalancer
			->
            debug:
              enabled: true
			<-

- service / debug / enabled: true
Funciona apenas para casos sem javaOpts(/extra)?
- flow: funciona
- payments: não funciona

# commands
- kubectl cluster-info
cluster details

- kubectl get nodes
all nodes that can be used to host our applications

- kubectl create deployment
kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1
kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4

"Let’s deploy our first app on Kubernetes with the kubectl create deployment command. We need to provide the deployment name and app image location (include the full repository url for images hosted outside Docker hub)."

- kubectl get deployments
To list your deployments use the get deployments
 -NAME lists the names of the Deployments in the cluster.
 -READY shows the ratio of CURRENT/DESIRED replicas
 -UP-TO-DATE displays the number of replicas that have been updated to achieve the desired state.
 -AVAILABLE displays how many replicas of the application are available to your users.
 -AGE displays the amount of time that the application has been running.

- kubectl proxy
Pods that are running inside Kubernetes are running on a private, isolated network. By default they are visible from other pods and services within the same kubernetes cluster, but not outside that network. When we use kubectl, we're interacting through an API endpoint to communicate with our application.
We will cover other options on how to expose your application outside the kubernetes cluster in Module 4.
The kubectl command can create a proxy that will forward communications into the cluster-wide, private network. The proxy can be terminated by pressing control-C and won't show any output while its running.
We will open a second terminal window to run the proxy.

- kubectl logs $pod
logs for pod. (logs are from stdout)

- kubectl exec $pod env
We can execute commands directly on the container once the Pod is up and running. For this, we use the exec command and use the name of the Pod as a parameter.
Let’s list the environment variables

- kubectl exec -ti $pod bash
open bash in pod

- kubectl get services
list services

- kubectl expose deployment/kubernetes-bootcamp --type="NodePort" --port 8080
expose the deployment as a service

- kubectl get pods -l run=kubernetes-bootcamp
get pods with label run=<app>

- kubectl get services -l run=kubernetes-bootcamp
get services with label run=<app>

- kubectl get rs
Two important columns of this command are:
 -DESIRED displays the desired number of replicas of the application, which you define when you create the Deployment. This is the desired state.
 -CURRENT displays how many replicas are currently running.

- kubectl scale deployments/kubernetes-bootcamp --replicas=4
scale to 4 replicas

- kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v2
update app with new image.
terminates old and starts new
v2 is version tag

- kubectl rollout status deployments/kubernetes-bootcamp
status of rollout update

- kubectl rollout undo deployments/kubernetes-bootcamp
rollback update

kubectl get - list resources
kubectl describe - show detailed information about a resource
kubectl logs - print the logs from a container in a pod
kubectl exec - execute a command on a container in a pod

## Pod names
export POD=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $pod

## Logs
Anything that the application would normally send to STDOUT becomes logs for the container within the Pod.
We can retrieve these logs using the kubectl logs command.
kubectl logs $pod

## Exec
kubectl exec $pod env

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

# SSH tunnels
ssh_tunnel=[<bind_address>:]<bind_port>:<host>:<host_port>
e.g.: 8443:10.104.168.22:8443

- background process
ssh -fNL $ssh_tunnel <user>@<server>
- background in shell
ssh -NnL $ssh_tunnel <user>@<server>

## research
https://stackoverflow.com/questions/36306904/configure-kubectl-command-to-access-remote-kubernetes-cluster-on-azure

search by label
POD=$(kubectl get pod -l app=my-app -o jsonpath="{.items[0].metadata.name}")
use -o name instead of -o jsonpath=...?
dbs-product-summary-arrangementsintegrationservice
kubectl get pod -l app=dbs-product-summary-arrangementsintegrationservice -o jsonpath="{.items[0].metadata.name}"


## reference by pedromendes

#get all services
kubectl get services

#get contexts
kubectl config get-contexts

#get all virtual services
get virtualservices
NAME       GATEWAYS                                                           HOSTS                                          AGE
edge       [istio-autogenerated-k8s-ingress.istio-system.svc.cluster.local]   [app.dev.bnp.live.backbaseservices.com]        27h
identity   [istio-autogenerated-k8s-ingress.istio-system.svc.cluster.local]   [identity.dev.bnp.live.backbaseservices.com]

#get pods list
kubectl get pods --namespace=backbase

#get virtual service
kubectl get virtualservice/identity

#get containers
kubectl get pods -o jsonpath="{..image}" |\
tr -s '[[:space:]]' '\n' |\
sort |\
uniq -c

kubectl get jobs -o jsonpath="{..image}" |\
tr -s '[[:space:]]' '\n' |\
sort |\
uniq -c

#describe pod
kubectl describe pod bnp-onboarding-service-bnp-onboarding-service-7db6dbbdc9-vm2wx
kubectl describe pod identity-devicemanagementservice-7f7c7794-8bfcb
kubectl describe pod cxs-portal-67b45cb686-22wbs

#encode a secret
echo -n '<secret>' | base64

#get secrets
kubectl get secrets
kubectl get secret identity -ojson  | jq -r '.data ["identity-password"]'  | base64 --decode
kubectl get secret identity -ojson  | jq -r '.data ["identity-username"]'  | base64 --decode
kubectl get secret identity -ojson  | jq -r '.data ["db-cxs-portal"]'  | base64 --decode

kubectl get secret osiptel-api-client-secrets -ojson
kubectl get secret telefonica-sms-api-client-secrets -ojson
kubectl get secret identity -ojson
kubectl get secret db-identity-backbaseidentity -ojson
kubectl get secret database -ojson



#check portal logs
kubectl logs -f cxs-portal-5f87984fc6-vxjjg portal
#check edge logs
kubectl logs -f ips-edge-edge-5dfcb6bb8d-jhbn7 edge
#check identity logs
kubectl logs -f identity-backbaseidentity-b45cb6776-2tkxr identity
#check flow logs
kubectl logs -f  flow-onboarding-us-flow-onboarding-us-7c7c9c49cd-zm2lk flow-onboarding-us
#check service logs
kubectl --namespace backbase logs -f bnp-transaction-int-service-bnp-transaction-int-service-64qxsnz main

kubectl --namespace backbase logs -f bnp-account-integration-service-bnp-account-integration-segc9tq main


#get jobs
kubectl get jobs
#kill a pod
kubectl delete pods identity-backbaseidentity-56dcbfffb5-n8pxw
kubectl delete job job-initial-user-ingestion-batch-task-2512449827

#check jobs logs
kubectl logs -f job/cxs-portal-content-base-provision-z9ajn
kubectl logs -f job/bnp-onboarding-service-bnp-onboarding-service-6644fc6656-2s5sg bnp-onboarding-service
kubectl logs -f job/job-initial-user-ingestion-batch-task-2512449827


#Reapply the content provisioning job [for each runtime]
kubectl delete helmrelease cxs-portal-content-base
kubectl delete helmrelease cxs-portal-content-bnp-retail-app

kubectl delete helmrelease identity
fluxctl sync --k8s-fwd-ns=gitops
#check the content portal provision job logs to prove that import was finished successfully
kubectl logs -f $(kubectl get po -o name | grep cxs-portal-content-base-provision)
kubectl logs -f $(kubectl get po -o name | grep bnp-transaction-int-service) main
kubectl logs -f $(kubectl get po -o name | grep bnp-event-listener-service) main
kubectl logs -f $(kubectl get po -o name | grep bnp-onboarding-service) main
kubectl logs -f $(kubectl get po -o name | grep identity-backbaseidentity) backbaseidentity
kubectl logs -f $(kubectl get po -o name | grep cxs-portal) portal

kubectl logs -f  bnp-onboarding-service-bnp-onboarding-service-789f6b498-n72cz main

# check the dbs logs
kubectl logs -f dbs-product-summary-arrangementmanager-76c56bdfff-f8j72 arrangementmanager
kubectl logs -f bnp-account-integration-service-bnp-account-integration-seh447g main


#Reapply the content provisioning job [for each runtime]
kubectl delete helmrelease bnp-onboarding-service
fluxctl sync --k8s-fwd-ns=gitops
#check the content retail app provision job logs to prove that import was finished successfully
$(kubectl get po -o name | grep bnp-onboarding-service)

#get pod yaml config
kubectl delete helmrelease bnp-transaction-int-service
kubectl describe helmrelease bnp-transaction-int-service
kubectl describe helmrelease bnp-event-listener-service
kubectl describe helmrelease bnp-onboarding-service
kubectl describe helmrelease bnp-user-profile-service
kubectl describe helmrelease cxs-portal
kubectl describe helmrelease identity
kubectl describe helmrelease jobs/job-initial-user-ingestion-batch-task-2115268370
kubectl describe helmrelease jobs/cxs-portal-content-bnp-retail-app-provision


kubectl get po -oyaml cxs-portal-content-bnp-retail-app-provision-9ebcl-588d8
kubectl get po -oyaml identity-devicemanagementservice-c87f9b4c-pkdcx

# get deployments and delete
kubectl get deployments
kubectl delete deployment pedro-curl

# you can scale them down and then up again if it gets stuck
kubectl -n gitops scale deploy flux --replicas 0
kubectl -n gitops scale deploy helm-operator --replicas 0


#describe aws ECR images
aws ecr describe-images --repository-name cxs-portal-content --region us-east-1
aws ecr describe-images --repository-name bnp-retail-app --region us-east-1

aws ecr describe-images --repository-name identity-integration-service --region us-east-2
aws ecr describe-images --repository-name identity-fidoservice --region us-east-2

#list ECR images
aws ecr list-images --repository-name cxs-portal-content --region us-east-2
aws ecr list-images  --region us-east-2

# run curl in a pod
- run image
  kubectl run test-pod -it --image=alpine -- sh
  apk add curl
or
  kubectl run test-pod -it --image=dwdraju/alpine-curl-jq -- sh
or
  kubectl run test-pod -it --image=praqma/network-multitool -- sh

- attach it after closing
kubectl attach test-pod -c test-pod -it

- delete pod / deployment
kubectl delete pod test-pod
or
kubectl delete deployment test-pod


# apply secrets
kubectl apply -f mysecret.yaml

# update a job without generating everything again
## 1. pull the latest .yaml from master (eg baas-bnp-applications-live/runtime/stg/live/jobs/jobs.yaml)
## 2. edit the fields - increment the id
## 3. apply
kubectl apply -f jobs.yaml

#encode val
echo -n 'secret' | base64

# port forwarding for database
define vars:
db_uri

then:

db_pod=db
kubectl run --restart=Never --image=alpine/socat $db_pod -- -d tcp-listen:8080,fork,reuseaddr tcp-connect:$db_uri
kubectl port-forward $db_pod 13306:8080

# forward
## cleanup the pod afterwards using:
kubectl delete pod portforward

#scale a deployment
kubectl get deployments
kubectl scale deployments/cxs-portal --replicas=0
kubectl scale deployments/dbs-access-control-accesscontrol --replicas=3
kubectl scale deployments/dbs-access-control-usermanager --replicas=3

kubectl scale deployments/bnp-onboarding-service-bnp-onboarding-service --replicas=3

#ref port-forward
pf_pod=pfwd-bbid
pf_target=identity-backbaseidentity:8080
k run --restart=Never --image=alpine/socat $pf_pod -- -d tcp-listen:8080,fork,reuseaddr tcp-connect:$pf_target
k port-forward $pf_pod 9999:8080

pf_pod=pfwd-bbid-debug
pf_target=identity-backbaseidentity:5005
k run --restart=Never --image=alpine/socat $pf_pod -- -d tcp-listen:8080,fork,reuseaddr tcp-connect:$pf_target
k port-forward $pf_pod 5005:8080

#ref create-pod
pod=test-pod

## create
k run $pod -it --image=alpine -- sh
## commands
apk add curl
<do stuff>
## attach
k attach $pod -c $pod -it

# deployment management
dep=bnp-cardless-withdrawal-service-bnp-cardless-withdrawal-service
rev=8
k rollout history deployment $dep
k rollout history deployment $dep --revision=$rev
k rollout undo deployment $dep
k rollout undo deployment $dep --to-revision=$rev
k edit deployments.apps $dep

# recreate schemas example
for secret_name in db-dbs-access-control-accesscontrol db-dbs-access-control-usermanager db-dbs-access-control-userprofilemanager db-dbs-product-summary-arrangementmanager
do
    DB_NAME=$(kubectl get secret $secret_name -o yaml | awk -F: -v key="  db_name"  '$1==key {print $2}' | base64 --decode)
    DB_USERNAME=$(kubectl get secret $secret_name -o yaml | awk -F: -v key="  db_username"  '$1==key {print $2}' | base64 --decode)
    DB_PASSWORD=$(kubectl get secret $secret_name -o yaml | awk -F: -v key="  db_password" '$1==key {print $2}' | base64 --decode)
    echo "Re-Creating DB SCHEMA $DB_NAME"
    kubectl run -n backbase mysql -i -t --image=alpine -- /bin/sh -c 'apk add mysql-client; mysql -u'$DB_USERNAME' -h ref-ds-eu-central-1.cluster-ckp12olmvmej.eu-central-1.rds.amazonaws.com -p'$DB_PASSWORD' -Bse "DROP SCHEMA \`'$DB_NAME'\`; commit; CREATE SCHEMA \`'$DB_NAME'\`; commit;" '
    kubectl delete pod mysql -n backbase
done

kubectl delete pod $(kubectl get pods | grep ^dbs-access-control-accesscontrol -m1| awk '{print$1}')
kubectl delete pod $(kubectl get pods | grep ^dbs-access-control-userprofilemanager -m1| awk '{print$1}')
kubectl delete pod $(kubectl get pods | grep ^dbs-access-control-usermanager -m1| awk '{print$1}')
kubectl delete pod $(kubectl get pods | grep ^dbs-product-summary-arrangementmanager -m1| awk '{print$1}')


# Helm
helm list
helm rollback <name>

## Fixing failed helm deployment
https://docs.fluxcd.io/projects/helm-operator/en/stable/helmrelease-guide/reconciliation-and-upgrades/
helm list
helm rollback <name>
