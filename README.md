# docker-graphite-api

Builds a docker image for running aprphite-api web application running in
gunicorn and the carbon-cache metrics listener in container.

## Requirements

A working Docker setup and a valid shell (e.g., bash).

## Getting Started
Build the container and run it.

## Example

```
./build.sh
docker run -t -i -d -p 8000:8000 -p 2003:2003 vmware-opencloud/graphite-api

This command opens a listener for metrics from other hosts or containers on
port 2003 and starts up the graphite api webapp on port 8000. 

Sample queries:
Once the graphite-api is installed and colecting metrics from some source (such as collectd) queries may be made. Some samples:

http://graphite-api:8000/metrics/find?query=collectd.* will show all the servers feeding metrics through collectd

http://graphite-api:8000/metrics/search?query=collectd.cna-ubuntu-0.* would list all the metrics collected by collectd on the server cna-ubuntu-0

http://graphite-api:8000/render?target=collectd.cna-ubuntu-0.cpu-0.cpu-* would graph all the cpu metrics for cna-ubuntu-0

More information may be found at http://graphite-api.readthedocs.org/en/latest/api.html

``

## License

TBD

## Author Information

This role was created in 2015 by [Tom Hite / VMware](http://www.vmware.com/).
