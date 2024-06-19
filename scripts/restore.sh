#!/bin/bash

set -eo pipefail

if [[ $# != "1" ]]; then
	echo "Please supply a backup file to restore";
	exit 1;
fi

if [[ "$1" != /* ]]; then
	echo "Please use an absolute path to the backup file to restore";
	exit 1;
fi

if [ ! -f "$1" ]; then
	echo "The requested backup file does not exist: $1";
	exit 1;
fi

if [[ $(tar tzf "$1" | head -n1) != "snikket/" ]]; then
	echo "The provided file is not a valid Snikket backup file";
	exit 1;
fi

echo    "WARNING: This will replace all data currently in the $CONTAINER container"
echo    "         with the contents of the provided backup. If you continue, existing"
echo -n "         data in the container will be lost. Continue? [y/N] "
read -r -n1 -p "" continue_answer

case "$continue_answer" in
y|Y) echo "Ok, proceeding..." ;;
*) echo "Aborting."; exit 1 ;;
esac

exec docker run \
  --rm \
  --volumes-from=snikket \
  --mount type=bind,source="$1",destination=/backup.tar.gz \
  debian:bookworm-slim \
  bash -c "rm -rf /snikket/*; tar xvf /backup.tar.gz -C /"
