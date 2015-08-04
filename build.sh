#!/bin/sh
#title           :build.sh
#description     :This script will build a docker image via ./Dockerfile
#author		 :aebie@vmware.com
#date            :20150803
#license         :public domain, feel free to copy and use.
#version         :0.1
#usage		 :sh build.sh
#==============================================================================

echo "Starting build at: $(date +%Y%m%d)"

cd $(dirname $0)
docker build --rm=true -t vmware-opencloud/graphite-api .

echo "Completed build at: $(date +%Y%m%d)"
