#!/usr/bin/env bash

SSH_KEY=""
SERVER_USER=""
SERVER_HOSTNAME=""
SERVER_PATH=""

if [[ $# -eq 0 || $1 -eq 0 ]]; then
    DRY_RUN=
else
    DRY_RUN=-n
fi

rsync $DRY_RUN -arvhz -e "ssh -i $SSH_KEY -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --exclude-from=rsync.ignore ../../. "$SERVER_USER@$SERVER_HOSTNAME:$SERVER_PATH"
