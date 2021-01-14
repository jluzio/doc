# bash-completion-files

- mvn:
https://github.com/juven/maven-bash-completion

- kubectl
https://kubernetes.io/docs/reference/kubectl/cheatsheet/#kubectl-autocomplete
source <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first.
echo "source <(kubectl completion bash)" >> ~/.bashrc # add autocomplete permanently to your bash shell.

alias k=kubectl
complete -F __start_kubectl k
