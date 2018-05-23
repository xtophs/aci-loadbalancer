#!/bin/bash

. var.env

# Change these four parameters as needed
LOCATION=eastus

Create the storage account with the parameters
az storage account create \
    --resource-group $${RG} \
    --name $AZURE_STORAGE_NAME \
    --location $LOCATION \
    --sku Standard_LRS

# Export the connection string as an environment variable. The following 'az storage share create' command
# references this environment variable when creating the Azure file share.
export AZURE_STORAGE_CONNECTION_STRING=`az storage account show-connection-string --resource-group ${RG} --name ${AZURE_STORAGE_ACCOUNT} --output tsv`

echo AZURE_STORAGE_CONNECTION_STRING=\"$AZURE_STORAGE_CONNECTION_STRING\"
# Create the file share
az storage share create -n $SHARE_NAME

STORAGE_KEY=$(az storage account keys list --resource-group ${RG} --account-name $AZURE_STORAGE_ACCOUNT --query "[0].value" --output tsv)
echo $STORAGE_KEY
