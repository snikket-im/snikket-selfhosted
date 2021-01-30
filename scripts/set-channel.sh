#!/bin/bash

set -eo pipefail

if [[ "$#" != "1" ]]; then
	echo "Please supply the name of a channel to switch to"
	exit 1;
fi

case "$1" in
alpha|beta|dev|stable) ;;
*)
	echo "Invalid channel name: $1"
	echo "Choose from: dev, alpha, beta, stable"
	exit 1;
;;
esac

exec sed -i 's|^\( *image: snikket/[^:]*\):.*$|\1:'"$1"'|' docker-compose.yml
