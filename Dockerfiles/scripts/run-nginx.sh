#!/bin/bash

#exit on error
set -e

MOUNT_DIR=/mnt/azureshare

# test file system exists

echo Recording IP address 
IP_ADDRESS=$(hostname -i)

#echo server ${IP_ADDRESS} ${IP_ADDRESS} maxconn 32 >> ${MOUNT_DIR}/proxy.cfg
#cat ${MOUNT_DIR}/proxy.cfg 

cat << EOF > /usr/share/nginx/html/index.html 
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>Running on ${IP_ADDRESS}</p>
</body>
</html>
EOF

nginx -g "daemon off;"

