#!/bin/sh

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
gunicorn -b 0.0.0.0:${GRAPHITE_UI_PORT} -w 2 --access-logfile /var/log/gunicorn_access.log --error-logfile /var/$
