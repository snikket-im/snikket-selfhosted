#!/bin/bash

if [ ! -f docker-compose.yml ]; then
	echo 'Almost there! You need to run ./init.sh first :)'
	exit 1;
fi

exec docker compose up -d
