Helm: https://helm.sh/
Helm v2: https://v2.helm.sh/
Helmfile: https://github.com/roboll/helmfile

# docs
https://helm.sh/docs/
https://github.com/roboll/helmfile


# temp
https://www.jfrog.com/confluence/display/JFROG/Kubernetes+Helm+Chart+Repositories

helm repo add <REPO_KEY> http://<ARTIFACTORY_HOST>:<ARTIFACTORY_PORT>/artifactory/<REPO_KEY> --username <USERNAME> --password <PASSWORD>
helm repo update

###########
# Templates
Helm and Helmfile uses go templates with additional Sprig functions

- go templates
https://pkg.go.dev/text/template
- sprig functions
https://masterminds.github.io/sprig/


############
# helm     
############

chart=backbase-charts/backbase-env

- install
- uninstall
- repo

- show
helm show readme $chart
helm show chart $chart

- get <values|hooks|manifest|notes> <release>


############
# helmfile #
############
https://github.com/roboll/helmfile

- base
helmfile <subcommand>

use target helmfile with filter of label tier and component
helmfile -f <helmfile.yaml> --selector tier=ips,component=edge <subcommand>

selector (or -l)
  - can be any label defined: tier=ips,component=edge
  - can be release name: name=<release-name>

- lint (validation)
helmfile lint

- write values per release
helmfile write-values

- sync k8s with releases
helmfile sync
- same but only when there are changes (diff then sync if any changes)
helmfile apply

- list
helmfile list

- other commands
helmfile destroy
helmfile fetch
helmfile test
helmfile status
helmfile diff

- useful params
  - wait: wait for pods to be in ready state
  - timeout

- Templates
You can use go's text/template expressions in helmfile.yaml and values.yaml.gotmpl (templated helm values files). values.yaml references will be used verbatim. In other words:
  - for value files ending with .gotmpl, template expressions will be rendered
  - for plain value files (ending in .yaml), content will be used as-is
