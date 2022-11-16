#!/bin/bash

set -eo pipefail

for img in server cert-manager web-portal web-proxy; do
	podman pull docker.io/snikket/snikket-$img;
done
podman pod rm -f snikket
