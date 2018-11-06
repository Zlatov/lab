#!/usr/bin/env bash
set -eu
exit 0

# Принудительно запрашивать пароль
ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no user@host
