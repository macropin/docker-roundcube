#!/usr/bin/env bash

set -ex

genpasswd() {
    export LC_CTYPE=C  # Quiet tr warnings
    local l=$1
    [ "$l" == "" ] && l=16
    cat /dev/urandom | tr -dc A-Za-z0-9_ | head -c ${l}
}


# MySQL Service
export DB_DSNW="mysql://${DATABASE_USER-roundcube}:${DATABASE_PASS}@${DATABASE_HOST-$MARIADB_PORT_3306_TCP_ADDR}/${DATABASE_NAME-roundcube}"

# IMAP Service
export DEFAULT_HOST="${DEFAULT_HOST-ssl://${MAILSERVER_PORT_993_TCP_ADDR}:$MAILSERVER_PORT_993_TCP_PORT}"
export DEFAULT_PORT="${DEFAULT_PORT-$MAILSERVER_PORT_993_TCP_PORT}"

# SMTP Service
export SMTP_SERVER="${SMTP_SERVER-ssl://${MAILSERVER_PORT_465_TCP_ADDR}:$MAILSERVER_PORT_465_TCP_PORT}"
export SMTP_PORT="${SMTP_PORT-$MAILSERVER_PORT_465_TCP_PORT}"

export DES_KEY=$(genpasswd 24)

exec $@
