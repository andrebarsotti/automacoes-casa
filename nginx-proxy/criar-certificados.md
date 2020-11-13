
1. Criar certificado root

   ~~~ 
   openssl genrsa -out rootCA.key 4096
   openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.crt -subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=Andre Salvadeo"
   ~~~
