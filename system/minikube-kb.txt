Minikube
https://minikube.sigs.k8s.io/docs/

- start cluster
minikube start

- dashboard
minikube dashboard

- open service in browser
minikube service hello-minikube

- port-forward to service
kubectl port-forward service/hello-minikube 7080:8080

- Pause Kubernetes without impacting deployed applications
minikube pause

- Halt the cluster
minikube stop

- Delete all of the minikube clusters
minikube delete --all
