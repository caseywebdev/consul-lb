FROM alpine:3.6

ENV \
  CONSUL_TEMPLATE_VERSION='0.19.0' \
  CONTAINERPILOT_VERSION='3.3.4' \
  LE_DIR='/etc/letsencrypt/live/consul-lb'

RUN \
  apk --no-cache add certbot curl nginx openssl && \
  mkdir -p $LE_DIR /code/public /run/nginx && \
  curl -fLsS https://releases.hashicorp.com/consul-template/$CONSUL_TEMPLATE_VERSION/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.tgz | \
    tar xz -C /usr/local/bin && \
  curl -fLsS https://github.com/joyent/containerpilot/releases/download/$CONTAINERPILOT_VERSION/containerpilot-$CONTAINERPILOT_VERSION.tar.gz | \
    tar xz -C /usr/local/bin

WORKDIR /code

COPY bin /code/bin
COPY etc /code/etc

ENV \
  CONSUL_TAG_PREFIX='consul-lb=' \
  CONSUL_SERVICE_NAME='consul-lb' \
  CONSUL_SERVICE_TAGS='' \
  CONSUL_URL='http://consul.example.com:8500' \
  CONTAINERPILOT='/code/etc/containerpilot.json5' \
  LETSENCRYPT_EMAIL_ADDRESS='' \
  LETSENCRYPT_TEST_CERT='0' \
  USE_SSL='1'

CMD ["containerpilot"]
