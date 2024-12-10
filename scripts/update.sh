#!/bin/bash

set -eo pipefail

docker compose pull
docker compose up -d
