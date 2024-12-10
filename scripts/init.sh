#!/bin/bash

set -eo pipefail

if [ -f docker-compose.yml ]; then
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

if ! docker help compose >/dev/null; then
	echo "Docker Compose extension is required, but not installed."
	echo "Please follow the installation guide at https://docs.docker.com/compose/install/linux/#install-using-the-repository"
	exit 1;
fi

cp docker-compose.base.yml docker-compose.yml

if [ -f snikket.conf ]; then
	echo "It appears you already have a snikket.conf file"
	echo -n "Would you like to keep the existing file? [Y/n] "
	read -r -n1 -p "" remove_existing_config
	case "$remove_existing_config" in
	n|N) rm snikket.conf ;;
	*) exit 0 ;;
	esac
	echo ""
	echo ""
fi

echo "## Snikket setup ##"
echo ""
echo "Welcome to Snikket. We're nearly ready to start your"
echo "new Snikket service. First we need some configuration"
echo "details."

echo ""
echo ""
echo "Snikket domain. This is the domain name your Snikket"
echo "service will use. For example, 'example.com' or 'chat.example.com'."
echo "It must be a domain you own, with DNS records for this"
echo "server's IP address. The domain/subdomain you enter will be"
echo "dedicated to Snikket, and cannot be shared with e.g. a website."
echo ""
read -r -p "Enter domain: " SNIKKET_DOMAIN

echo ""
echo ""
echo "Admin email address. This is communicated to your users"
echo "of the $SNIKKET_DOMAIN service in case they require assistance."
echo "It is also provided to Let's Encrypt, an organization that issues"
echo "SSL/TLS certificates required for Snikket to encrypt connections."
echo ""
read -r -p "Enter admin email address: " SNIKKET_ADMIN_EMAIL

echo ""
echo ""
echo "Finally, please confirm that you accept the Let's Encrypt terms"
echo "of service, which can be reviewed at:"
echo "https://letsencrypt.org/documents/LE-SA-v1.2-November-15-2017.pdf"
echo ""
read -r -n1 -p "Enter 'Y' to confirm: " SNIKKET_LETSENCRYPT_TOS_AGREE
echo ""

case "$SNIKKET_LETSENCRYPT_TOS_AGREE" in
Y|y) ;;
*)
	echo "Snikket requires certificates from Let's Encrypt to set up"
	echo "the server. Since you do not accept the terms of service"
	echo "(you answered: $SNIKKET_LETSENCRYPT_TOS_AGREE), the installation"
	echo "cannot continue."
	echo "If you change your mind, you may re-run this script at any time."
	exit 1;
;;
esac

echo ""
sed \
  -e 's/^\(SNIKKET_DOMAIN\)=.*$/\1='"$SNIKKET_DOMAIN"'/;' \
  -e 's/^\(SNIKKET_ADMIN_EMAIL\)=.*$/\1='"$SNIKKET_ADMIN_EMAIL"'/;' \
  -e 's/^\(SNIKKET_LETSENCRYPT_TOS_AGREE\)=.*$/\1='"$SNIKKET_LETSENCRYPT_TOS_AGREE"'/;' \
  snikket.conf.example > snikket.conf

echo ""
echo 'Success! Your configuration has been saved. You may now run ./scripts/start.sh'

exit 0;
