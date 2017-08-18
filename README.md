# consul-lb

A [Consul]-aware load balancer powered by [nginx] and secured by [Let's
Encrypt].

### Installation

Either build the Dockerfile in this repo yourself or use one of the
[quay.io/coderiety/consul-lb] images. Then simply `docker run` the image with
your desired envvars (see below) and point your DNS records at the running
container.

### ENVVARS

**CONSUL_TAG_PREFIX**='consul-lb='
This is the tag prefix consul-lb will look for in each service to determine if
and when traffic should be routed to that service.

CONSUL_SERVICE_NAME='consul-lb'
CONSUL_SERVICE_TAGS=''
CONSUL_URL='http://consul:8500'
LETSENCRYPT_EMAIL_ADDRESS=''
LETSENCRYPT_TEST_CERT='0'
USE_SSL='1'

[Consul]: https://www.consul.io
[nginx]: https://nginx.org
[Let's Encrypt]: https://letsencrypt.org
[quay.io/coderiety/consul-lb]: https://quay.io/repository/coderiety/consul-lb?tab=tags
