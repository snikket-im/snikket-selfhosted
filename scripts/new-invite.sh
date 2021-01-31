#!/bin/bash

SNIKKET_DOMAIN=$(grep ^SNIKKET_DOMAIN= snikket.conf | cut -d= -f2)

if [[ -z "$SNIKKET_DOMAIN" ]]; then
	echo "Failed to read SNIKKET_DOMAIN from snikket.conf, unable to continue";
	exit 1;
fi

exec docker exec -it snikket prosodyctl mod_invites generate "$SNIKKET_DOMAIN" "$@"
