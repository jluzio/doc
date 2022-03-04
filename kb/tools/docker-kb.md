# Docker & Java debug
https://medium.com/swlh/remote-debugging-a-java-application-running-in-docker-container-with-intellij-idea-efe54cd77f02

- Remote
1) IDE
host: host.docker.internal
port: 5005

2) Docker file (docker-compose.yml)
Set JAVA_TOOL_OPTIONS environment variable for image

JAVA_TOOL_OPTIONS=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005
> JDK 5-8
-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005
> JDK 9 or later
-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005


- Backup/Restore
https://docs.docker.com/storage/volumes/#backup-restore-or-migrate-data-volumes

Set-Variable source_container_id mysql
## Windows
Set-Variable volume_data_path /var/lib/mysql
Set-Variable backup_filename backup.tar
Set-Variable backup_host_path $(pwd)

(Git Bash & others)
source_container_id=mysql
volume_data_path=/var/lib/mysql
backup_filename=backup.tar
backup_host_path=$(cygpath -w $(pwd))

## Linux
source_container_id=mysql
volume_data_path=/var/lib/mysql
backup_filename=backup.tar
backup_host_path=$(pwd)

# Backup
docker run --rm --volumes-from $source_container_id -v ${backup_host_path}:/backup busybox tar cvf /backup/$backup_filename $volume_data_path

## Restore
docker run --rm --volumes-from $source_container_id -v ${backup_host_path}:/backup busybox sh -c "rm -rf $volume_data_path/* && cd / && tar xvf /backup/$backup_filename"

## Test
docker run --rm --volumes-from $source_container_id -v ${pwd}/nginx.conf:/etc/nginx/nginx.conf:ro -p 8080:80 --name nginx_test -d nginx

- nginx.conf
events {
}

http {
  server {
    listen     80;
    server_name  localhost;

    location / {
      root   /var/lib/mysql;
      autoindex on;
    }
  }
}


- Read only
Volumes can be used read-only.
https://docs.docker.com/storage/volumes/#use-a-read-only-volume
Files that need the linux permission of read only (r, from rwx), can be used in Windows as a read-only which translates to r.

- Issues
https://forums.docker.com/t/port-mappings-are-not-released/10565/21
https://stackoverflow.com/questions/40159468/docker-does-not-release-ports-after-stop-and-remove-all-container

- Pull images
docker pull <image-id>
image-id: can be seen from Image/Image ID in Kubernetes (kubectl describe <pod>)

- Inspect
docker image inspect <image-id>
image-id: see in "docker images" / docker dashboard

- Files
imageId=$(docker create <image>)
docker cp $imageId:<image_path> <target_path>
e.g.:
imageId=$(docker create alpine)
docker cp $imageId:/ /home/tmp/docker/alpine

- Completion
compl_dir=/usr/share/bash-completion/completions/
curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/bash/docker -o $compl_dir/docker
curl -L https://raw.githubusercontent.com/docker/compose/1.28.5/contrib/completion/bash/docker-compose -o $compl_dir/docker-compose

# Registry
- run registry
docker run -d -p 5000:5000 --restart=always --name registry registry

registry=localhost:5000
registry_uri=http://$registry
image=identity-onespan-auth-service

docker tag <local-image-repository>:<local-image-tag> $registry/<local-image-name>
docker push $registry/<local-image-name>

e.g.:
docker tag remote.registry.url/identity-onespan-auth-service:2021.07 localhost:5000/identity-onespan-auth-service:2021.07
docker push localhost:5000/identity-onespan-auth-service:2021.07

curl -X GET $registry_uri/v2/_catalog
curl -X GET $registry_uri/v2/$image/tags/list

# Tools
- Dive: see image contents
 https://github.com/wagoodman/dive
