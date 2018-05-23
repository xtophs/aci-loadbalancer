#!/bin/bash

docker build -f Dockerfile.nginx -t nginx-share .
docker build -f Dockerfile.haproxy -t haproxy-share .

docker tag nginx-share:latest xtoph/nginx-share:latest
docker push xtoph/nginx-share:latest

docker tag haproxy-share:latest xtoph/haproxy-share:latest
docker push xtoph/haproxy-share:latest