
. var.env

UNIQUE=$RANDOM

rm ${PROXY_CFG_PATH}

az container create --resource-group ${RG} \
    --name xtophnginx$UNIQUE \
    --image xtoph/nginx-share:latest \
    --dns-name-label xtophnginx$UNIQUE \
    --ports 80 \
    --azure-file-volume-account-name ${AZURE_STORAGE_NAME} \
    --azure-file-volume-account-key ${AZURE_STORAGE_KEY} \
    --azure-file-volume-share-name ${SHARE_NAME} \
    --azure-file-volume-mount-path ${MOUNT_DIR}

cat << EOF > ${PROXY_CFG_PATH}
global
    daemon
    maxconn 256

defaults
    mode http
    timeout connect 5000ms
    timeout client 50000ms
    timeout server 50000ms

listen http-in
    bind *:80
#    server server1 127.0.0.1:8000 maxconn 32
EOF

IP=$(az container show -g xtoph-zenus-aci -n xtophnginx$UNIQUE --query 'ipAddress.ip' -o tsv)
echo Writing ${IP}
#echo "     server "${IP}" "${IP} >> ${PROXY_CFG_PATH}
echo "     server server1 "${IP} >> ${PROXY_CFG_PATH}


az container create --resource-group ${RG} \
    --name xtophhaproxy$UNIQUE \
    --image xtoph/haproxy-share:latest \
    --dns-name-label xtophhaproxy$UNIQUE \
    --ports 80 \
    --azure-file-volume-account-name ${AZURE_STORAGE_NAME} \
    --azure-file-volume-account-key ${AZURE_STORAGE_KEY} \
    --azure-file-volume-share-name ${SHARE_NAME} \
    --azure-file-volume-mount-path ${MOUNT_DIR}

IP=$(az container show -g ${RG} -n xtophhaproxy$UNIQUE --query 'ipAddress.ip' -o tsv)
echo Haproxy at: ${IP}
