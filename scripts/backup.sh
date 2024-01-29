#!/bin/bash

set -eo pipefail

if [[ $# != "1" ]]; then
	echo "Please supply a destination directory for the backup file";
	exit 1;
fi

if [[ "$1" != /* ]]; then
	echo "Please use an absolute path to the destination directory";
	exit 1;
fi

if [ ! -d "$1" ]; then
	echo "The provided destination directory does not exist: $1";
	exit 1;
fi

exec docker run --rm --volumes-from=snikket -v "$1":/backup debian:bookworm-slim tar czf /backup/snikket-"$(date +%F-%R)".tar.gz /snikket
