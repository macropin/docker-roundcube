#!/usr/bin/env bash

set -ex

genpasswd() {
    export LC_CTYPE=C  # Quiet tr warnings
    local l=$1
    [ "$l" == "" ] && l=16
    cat /dev/urandom | tr -dc A-Za-z0-9_ | head -c ${l}
}


# MySQL Service
export DB_DSNW="mysql://${DATABASE_USER:-roundcube}:${DATABASE_PASS}@${DATABASE_HOST:-$MARIADB_PORT_3306_TCP_ADDR}/${DATABASE_NAME:-roundcube}"

# IMAP Service
export DEFAULT_HOST="${DEFAULT_HOST-ssl://${MAILSERVER_PORT_993_TCP_ADDR}:$MAILSERVER_PORT_993_TCP_PORT}"
export DEFAULT_PORT="${DEFAULT_PORT:-$MAILSERVER_PORT_993_TCP_PORT}"

# SMTP Service
export SMTP_SERVER="${SMTP_SERVER:-ssl://${MAILSERVER_PORT_465_TCP_ADDR}:$MAILSERVER_PORT_465_TCP_PORT}"
export SMTP_PORT="${SMTP_PORT:-$MAILSERVER_PORT_465_TCP_PORT}"

export DES_KEY=$(genpasswd 24)

if [ "$SSL_ENABLED" == "true" ]; then
    a2enmod ssl
    export SSL_CRT=${SSL_CRT:-/etc/ssl/certs/ssl-cert-snakeoil.pem}
    export SSL_KEY=${SSL_KEY:-/etc/ssl/private/ssl-cert-snakeoil.key}
    export SSL_CA=${SSL_CA:-/etc/ssl/certs/ca-certificates.crt}
fi

# Apache MPM Tuning
export MPM_START=${MPM_START:-5}
export MPM_MINSPARE=${MPM_MINSPARE:-5}
export MPM_MAXSPARE=${MPM_MAXSPARE:-10}
export MPM_MAXWORKERS=${MPM_MAXWORKERS:-150}
export MPM_MAXCONNECTIONS=${MPM_CONNECTIONS:-0}

exec $@
