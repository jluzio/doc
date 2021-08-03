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

# Restore mysql example
Powershell>

## replace contents
docker run --rm --volumes-from nbb_mysql -v ${pwd}:/backup busybox sh -c "rm -rf /var/lib/mysql/* && cd /var/lib/mysql/ && tar xvf /backup/bb-platform_nbb_mysql_data.tar --strip 3"

## test
docker run --rm --volumes-from nbb_mysql -v ${pwd}/html:/usr/share/nginx/html:ro -p 8080:80 -d nginx


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

# Tools
- Dive: see image contents
 https://github.com/wagoodman/dive