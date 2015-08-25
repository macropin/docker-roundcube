# Roundcube Docker

[![Docker Repository on Quay.io](https://quay.io/repository/macropin/roundcube/status "Docker Repository on Quay.io")](https://quay.io/repository/macropin/roundcube)
[![](https://badge.imagelayers.io/macropin/roundcube:latest.svg)](https://imagelayers.io/?images=macropin/roundcube:latest)

Production ready Docker container for [Roundcube](https://github.com/roundcube/roundcubemail).

## Features

- Uses [debian](https://registry.hub.docker.com/_/debian/) base image
- Thin Container. Uses linked [MariaDB](https://registry.hub.docker.com/_/mariadb/) and IMAP containers for those services
- Installs latest Roundcube cleanly from Git source

## Environment variables

These are the base variables:

- `DATABASE_USER` - Required: Database username.
- `DATABASE_PASS` - Required: Database password.
- `DATABASE_HOST` - Optional: Database host, or use `--link mariadb`
- `DATABASE_NAME` - Optional: Database Name. Default 'roundcube'.
- `DEFAULT_HOST` - Optional: IMAP Host URL, or use `--link mailserver` (must expose port 993 imaps).
- `DEFAULT_PORT` - Optional: IMAP Port, or or use `--link mailserver` (must expose port 993 imaps).
- `SMTP_SERVER` - Optional: SMTP Host URL, or use `--link mailserver` (must expose port 465 smtps).
- `SMTP_PORT` - Optional: SMTP Port, or or use `--link mailserver` (must expose port 465 smtps).

SSL Configuration:

- `SSL_ENABLED` - Optional: Enable SSL
- `SSL_KEY` - Optional: Path to SSL Key
- `SSL_CRT` - Optional: Path to SSL Certificate
- `SSL_CA` - Optional: Certificate Authority Chain

## Status

Production Ready.
