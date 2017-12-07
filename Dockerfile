# docker build --no-cache -t seandou/go-dnsmasq:latest .
# docker push seandou/go-dnsmasq:latest

FROM alpine:3.6
MAINTAINER seandou <douguohui@gmail.com>

# Replace repositories
ADD files/repositories /etc/apk/repositories

# Install basic tools
RUN apk add --no-cache bash bash-completion ca-certificates \
    tzdata \
    tree vim htop

# Set timezone
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Copy privoxy config file
COPY files/go-dnsmasq /go-dnsmasq
RUN chmod +x /go-dnsmasq

ENV DNSMASQ_LISTEN=0.0.0.0
EXPOSE 53 53/udp

# Copy entrypoint.sh
COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

CMD ["/entrypoint.sh"]
