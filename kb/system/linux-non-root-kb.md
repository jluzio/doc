# using linux apps with root

## Git install
http://thirtybytes.com/?p=245

## Homebrew
Install without root privileges
https://superuser.com/questions/619498/can-i-install-homebrew-without-sudo-privileges

~~~bash
mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
~~~

## cURL
https://curl.se/download/

- binaries
https://curl.se/dlwiz/

- source instructions
https://help.dreamhost.com/hc/en-us/articles/360043102852-Installing-a-custom-version-of-curl-command-line-tool-

~~~bash
curl -L https://github.com/moparisthebest/static-curl/releases/download/v8.0.1/curl-amd64 -o ~/bin/curl
~~~~

~~~bash
# download source, unpack and then:
./configure --with-openssl --prefix=/home/joao.l/opt/curl
make
make install

# possibly add export to bash profile, so libcurl from the built code is used
# export LD_LIBRARY_PATH="$HOME/opt/curl/lib:$LD_LIBRARY_PATH"
~~~
