# consul-lb

A [Consul]-aware load balancer powered by [nginx] and secured by [Let's
Encrypt].

```sh
# Docker is required.
docker run

  # Expose port 80 on the host for HTTP traffic.
  -p 80:80

  # If USE_SSL=1 (default), expose port 443 for HTTPS traffic.
  -p 443:443

  # ENVVARS, or how to configure consul-lb to work for you. Each configuration
  # envvar is listed below with its default value.

  # This is the tag prefix consul-lb will look for in each service to determine
  # if and when traffic should be routed to that service. For example a service
  # that registers with the tag "consul-lb.url=foo.example.com" will be routed
  # traffic that hits consul-lb from the host "foo.example.com". Path routing is
  # also supported, so a service that registers with the tag
  # "consul-lb.url=bar.example.org/baz" will receive traffic from the host
  # "bar.example.org" and the path "/baz".
  #
  # To enable basic auth for a service, add the tag "<your prefix>.auth=<consul
  # key>" where the value at <consul key> is a basic auth user file as defined
  # at
  # http://nginx.org/en/docs/http/ngx_http_auth_basic_module.html#auth_basic_user_file
  -e CONSUL_TAG_PREFIX='consul-lb'

  # This is the service name with which consul-lb will register in consul, as
  # well as the first part of the kv path consul-lb will be using for storage.
  -e CONSUL_SERVICE_NAME='consul-lb'

  # This is a comma-delimited list of tags to with which the service will
  # register in consul.
  -e CONSUL_SERVICE_TAGS=''

  # This is the URL to the consul API.
  -e CONSUL_URL='http://consul:8500'

  # This is an optional email address that Let's Encrypt will use for any
  # communication regarding expiring certificates or other issues related to
  # your certs.
  -e LETSENCRYPT_EMAIL_ADDRESS=''

  # Let's Encrypt has a pretty conservative rate limit on cert requests. It's
  # recommended that when you're testing your DNS settings to make sure
  # everything is lined up correct you set this value to '1' to enable the use
  # of Let's Encrypt's staging servers. You can confirm everything is working
  # correctly if you visit your secured domain and see an untrusted cert from
  # Let's Encrypt. Once you see that, you can set this flag back to '0' and
  # consul-lb will request a trusted cert.
  -e LETSENCRYPT_TEST_CERT='0'

  # This is the flag that enables Let's Encrypt automatic SSL certificate
  # generation. You may want to set this to '0' in development or for an
  # internal load balancer where Let's Encrypt certs are not possible or needed.
  -e USE_SSL='1'

  # You can run the pre-built image or modify this repo and build your own.
  # quay.io/coderiety/consul-lb images are tagged by git branch, git tag, and
  # git SHA.
  coderiety/consul-lb:master
```

[Consul]: https://www.consul.io
[nginx]: https://nginx.org
[Let's Encrypt]: https://letsencrypt.org
