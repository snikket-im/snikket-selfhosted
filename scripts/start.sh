#!/bin/bash

if [ ! -f podman-compose.yml ]; then
	echo 'Almost there! You need to run ./init.sh first :)'
	exit 1;
fi

exec podman play kube --configmap=snikket-settings.yml podman-compose.yml
