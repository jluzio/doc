# certificates

## ref
https://docs.oracle.com/javase/8/docs/technotes/tools/unix/keytool.html
https://www.baeldung.com/keytool-intro
https://www.sslshopper.com/article-most-common-java-keytool-keystore-commands.html

## list
keytool -list -rfc -keystore example.jks -storepass changeit

## export all certificates
[Bug]: doesn't deal with names with spaces
[Todo]: fix it
#!/bin/bash
keystore=$1
storepass=${1:-changeit}
for cert in $(keytool -list -keystore $keystore -storepass $storepass | grep trustedCertEntry | grep -Eo "^[^,]*");do
    echo keytool -exportcert -keystore cacerts -alias $cert -file ${cert}.crt <<< $'changeit'
done

## debug
https://docs.oracle.com/javase/8/docs/technotes/guides/security/jsse/ReadDebug.html
-Djavax.net.debug=all

## import and add to keystore
https://stackoverflow.com/a/11617655/13181895

You can download the SSL certificate from a web server that is already using it like this:
echo -n | openssl s_client -connect www.example.com:443 | \
   sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /tmp/examplecert.crt

Optionally verify the certificate information:
openssl x509 -in /tmp/examplecert.crt -text

Import the certificate into the Java cacerts keystore:
keytool -import -trustcacerts -keystore /opt/java/jre/lib/security/cacerts \
   -storepass changeit -noprompt -alias mycert -file /tmp/examplecert.crt
