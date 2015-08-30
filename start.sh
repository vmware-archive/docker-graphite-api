#!/bin/sh
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

cat >/etc/graphite-api.yaml <<-EOF
search_index: /srv/graphite/index
finders:
  - graphite_api.finders.whisper.WhisperFinder
functions:
  - graphite_api.functions.SeriesFunctions
  - graphite_api.functions.PieFunctions
whisper:
  directories:
    - /var/lib/graphite/whisper
carbon:
  hosts:
    - 127.0.0.1:7002
  timeout: 1
  retry_delay: 15
  carbon_prefix: carbon
  replication_factor: 1
time_zone: UTC
allowed_origins:
    - '*'
EOF

cat >/etc/carbon/storage-schemas.conf <<-EOF
[carbon]
pattern = ^carbon\.
retentions = 60:90d
[collectd]
pattern = ^collectd.*
retentions = 10s:1d,1m:7d,10m:1y
[default_1min_for_1day]
pattern = .*
retentions = 60s:1d
EOF

cat >/etc/default/graphite-carbon <<-EOF
CARBON_CACHE_ENABLED=true
EOF

service carbon-cache start
gunicorn -b 0.0.0.0:${GRAPHITE_UI_PORT} -w 2 --access-logfile /var/log/gunicorn_access.log --error-logfile /var/log/gunicorn_error.log --log-level error graphite_api.app:app
