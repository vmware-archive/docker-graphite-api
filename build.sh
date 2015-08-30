#!/bin/sh
#
#author		 :aebie@vmware.com
#date            :20150803
#version         :0.1
#usage		 :sh build.sh
#==============================================================================
#
#  Copyright 2015 VMware, Inc.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

echo "Starting build at: $(date +%Y%m%d)"

cd $(dirname $0)
docker build --rm=true -t vmware-opencloud/graphite-api .

echo "Completed build at: $(date +%Y%m%d)"
