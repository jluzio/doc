# Useful info

# Bash reverse-i-search
CTRL-R: searchs history of commands
After typing filter, CTRL-R goes to next match

# less
## save current buffer to file
s -> <filename>

## save buffer to file (dd)
- Optionally mark with `m <mark_key>`
- Type `|` (that's a pipe character) to indicate that you want to output to a pipe
- Type `$` or `mark_key` to indicate that you want the output content to go to the end of the file
- Type `dd of=/path/to/new/file` and press Enter
- The dd command will take the piped data and save it to the file passed to the of= argument.

## save buffer to clipboard (xclip)
- Optionally mark with `m <mark_key>`
- Type `|` (that's a pipe character) to indicate that you want to output to a pipe
- Type `$` or `mark_key` to indicate that you want the output content to go to the end of the file
- Type `xclip -selection clipboard` and press Enter (or `xclip` to save and `xclip -o` to output saved data)

# grep
- multiple files: grep -rni (r: recursive, n: display line, i: ignore case)

# sshuttle - transparent proxy meets vpn meets ssh
https://github.com/sshuttle/sshuttle
https://sshuttle.readthedocs.io/en/stable/overview.html
sshuttle --dns -r <user>@<server> -x <server> 0.0.0.0/0

# SSH Port Forward
ssh -Nn -D :<port> <user>@<server>

# SSH login using public key
https://kb.iu.edu/d/aews
- ssh-keygen -t rsa
- append ~/.ssh/id_rsa.pub into <server>/.ssh/authorized_keys
cat ~/id_rsa.pub >> ~/.ssh/authorized_keys

# SSH escape commands
To disconnect a locked-up ssh session, type "Enter ~."
A full list of escape codes can be found in the ssh manpage or by typing ~?.

# Homebrew
https://brew.sh/

## install previous package version
https://cmichel.io/how-to-install-an-old-package-version-with-brew/

# SSH tunnels
ssh_tunnel=[<bind_address>:]<bind_port>:<host>:<host_port>
e.g.: 8443:10.104.168.22:8443

- background process
ssh -fNL $ssh_tunnel <user>@<server>
- background in shell
ssh -NnL $ssh_tunnel <user>@<server>


# Get Certificates
host=dev.example.org
host_port=443
echo | openssl s_client -showcerts -servername $host -connect $host:$host_port 2>/dev/null | openssl x509 -inform pem -noout -text > ${host}_cert.txt


# Replace text in file
sed -i 's/search_string/replace_string/' filename


# JQ
.results[0].items | map(select(.case_definition_schema_version == 34)) | map(.case_key)

# Run a command with interval
## watch <option> cmd
e.g.:
- Run date command every 10 seconds
watch --interval=10 date

## sleep
while true; do <cmd>; sleep <secs>; done

# Bash
- expand env variables with directory paths
shopt -s direxpand

- undo
ctrl + /
- paste what is in buffer (may work as undo in some scenarios)
ctrl + y (yank: pastes what is in the buffer, )
- delete words/text
left: ctrl + w
right: alt + d

# execute a command for each file
find . -maxdepth 1 -type f -exec <cmd> {} \;

## rename all exts
find . -name '*.txt' -exec bash -c 'mv "$0" "${0%.txt}.md"' "{}" \;

## bash arrays
values1=(value_1_1 value_1_2)
values2=(values_2_1)
all_values=("${values1[@]}" "${values_2[@]}")

for val in "${all_values[@]}";
do
  echo $val
done

# sync dirs
rsync -a --delete <source_dir>/ <target_dir>
note: slash at end of <source_dir> ensures it won't be copied as a subdir of <target_dir>

# delete directories with name
https://stackoverflow.com/questions/42950501/delete-node-modules-folder-recursively-from-a-specified-path-using-command-line

find . -name '<dir_name>' -type d -prune -exec rm -rf '{}' +

https://github.com/voidcosmos/npkill
npx npkill
(defaults to node_modules)
npkill --target <dir_name> -e

# compressed files
- uncompress
tar.gz: tar –xvzf documents.tar.gz

# util commands
- date with format
~~~bash
date +%Y-%m-%d
echo $(date +%Y-%m-%d)
~~~
~~~bash
mkdir $(date +%Y%m%d) ; cd $(date +%Y%m%d)
~~~

# run a curl command every x seconds to see if url is up
~~~bash
while :; do curl -s https://someurl.com > /dev/null && echo "Success" || echo "Fail"; sleep 1; done
~~~

# fzf - fuzzy find files
~~~bash
# default
fzf
# preview contents
fzf --preview 'cat {}'
# open nvim with the file selected using fzf
nvim $(fzf --preview 'cat {}')
~~~

# exclude results using grep
~~~bash
# grep -v <pattern> : excludes lines matching the pattern
# example for listing all containers and excluding the k8s ones
docker ps --all | grep -v "k8s"
~~~
