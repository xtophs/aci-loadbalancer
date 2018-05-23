#!/bin/bash

. var.env

echo Checking environment
# Test Environment Variables
[ -z "$AZURE_STORAGE_ACCOUNT" ] && echo AZURE_STORAGE_ACCOUNT is not set correctly && exit 1
[ -z "$AZURE_STORAGE_KEY" ] && echo AZURE_STORAGE_KEY is not set correctly && exit 1

echo Environment Set Correctly. Lets AZURE_STORAGE_ACCOUNT
# Create Mount Point
mkdir ${MOUNT_DIR}

echo Mounting
# Mount 
mount -t cifs //${AZURE_STORAGE_ACCOUNT}.file.core.windows.net/${SHARE_NAME} ${MOUNT_DIR} -o vers=3.0,username=${AZURE_STORAGE_ACCOUNT},password=${AZURE_STORAGE_KEY},dir_mode=0777,file_mode=0777,serverino
