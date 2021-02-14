#!/bin/bash

set -eo pipefail

echo "Renewing certificates..."
docker exec -it snikket-certs /etc/cron.daily/certbot

echo "Reloading services..."
docker exec -it snikket-proxy service nginx reload
docker exec -it snikket supervisorctl signal hup prosody

echo "Complete."

exit 0;
