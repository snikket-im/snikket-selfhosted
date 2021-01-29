#!/bin/bash

set -eo pipefail

if test -f docker-compose.yml; then
	echo "You already have a docker-compose.yml."
	echo "If you want to recreate it, please remove it first and re-run this command"
	exit 1;
fi

## Platform detection ##
OS=$(awk '/DISTRIB_ID=/' /etc/*-release | sed 's/DISTRIB_ID=//' | tr '[:upper:]' '[:lower:]')
if [ -z "$OS" ]; then
    OS=$(awk '{print $1}' /etc/*-release | tr '[:upper:]' '[:lower:]')
fi

if [ -z "$VERSION" ]; then
    VERSION=$(awk '{print $3}' /etc/*-release)
fi
########################


if ! which docker >/dev/null; then
	echo "Docker is required but not installed."
	case "$OS" in
	ubuntu|debian|fedora|centos)
		echo "Please follow the guide at https://docs.docker.com/install/linux/docker-ce/$OS/" ;;
	*)
		echo "Please follow the installation guide at https://docs.docker.com/engine/install/" ;;
	esac
	exit 1;
fi

if ! which docker-compose >/dev/null; then
	echo "Docker Compose (docker-compose) is required but not installed."
	echo "Please follow the installation guide at https://docs.docker.com/compose/install/"
	exit 1;
fi

mv docker-compose.base.yml docker-compose.yml

exit 0;
