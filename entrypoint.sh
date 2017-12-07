#!/bin/bash

OPTS=""

if [ -f "/etc/go-dnsmasq/env" ]; then
    source /etc/go-dnsmasq/env
fi

HOSTS_FILE="/etc/go-dnsmasq/hostsfile"
if [ -f $HOSTS_FILE ]; then
    OPTS="$OPTS -f $HOSTS_FILE"
fi

if [ -n "$NAMESERVERS" ]; then
    OPTS="$OPTS --nameservers $NAMESERVERS"
fi

/go-dnsmasq $OPTS
