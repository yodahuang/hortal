FROM alpine:3

RUN apk --no-cache add dnsmasq

VOLUME /etc/dnsmasq

ENTRYPOINT ["dnsmasq", "-k"]