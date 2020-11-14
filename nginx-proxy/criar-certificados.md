
1. Criar certificado root

   ~~~ 
   openssl genrsa -out rootCA.key 4096
   openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.crt -subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=Andre Salvadeo"
   ~~~

2. Unir certificado como um pfx.

   ~~~
   openssl pkcs12 -export -inkey emby.localhost.key -in emby.localhost.crt -certfile localhostRoot.crt -out emby.localhost.p12
   ~~~