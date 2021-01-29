#!/bin/bash

set -eo pipefail

if test -f docker-compose.yml; then
	echo "You already have a docker-compose.yml."
	echo "If you want to recreate it, please remove it first and re-run this command"
	exit 1;
fi

mv docker-compose.base.yml docker-compose.yml

exit 0;
