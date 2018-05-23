#!/bin/bash

set -e

MOUNT_DIR=/mnt/azureshare

# TODO verify that mount exists 

# TODO Send SIGHUP to the container to reload
# TODO Have multiple HAProxy in HA config for availability

# run haproxy
/docker-entrypoint.sh haproxy -f ${MOUNT_DIR}/proxy.cfg 