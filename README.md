# snikket-selfhosted

This repository includes some helpful scripts and templates
for setting up and managing a Snikket service, as an alternative to the
official [Snikket setup guide](https://snikket.org/quickstart).

If you use the scripts here, feel free to send us feedback or contributions to
help improve them!

**Note:** These scripts now require Docker Compose V2, and won't work with the
V1 'docker-compose' command that some servers may still have installed. If you
need to upgrade, follow [Docker's installation guide for Compose V2](https://docs.docker.com/compose/install/linux/#install-using-the-repository).

## Setup instructions

Before you begin, you need to follow Step 1 (DNS) and Step 2
(Docker) from the [Quickstart](https://snikket.org/service/quickstart/)
tutorial.

Instead of Step 3 in the quickstart, you can follow the instructions
here.

Don't forget to run the commands as root (log in as root or use sudo).

### Step 1: Fetch the source

```
cd /opt
git clone https://github.com/snikket-im/snikket-selfhosted snikket
```

### Step 2: Configure

An automatic configuration script is included:

```
cd snikket
./scripts/init.sh
```

### Step 3: Start!

```
./scripts/start.sh
```

Check that your Snikket login page loads at `http://<your domain>/`
(it will redirect to HTTPS once certificates are available).

### Step 4: Create an admin account

To create your first account, create an invitation with:

```
./scripts/new-invite.sh --admin --group default
```

Open the link in a browser. If you are on a desktop, you can use
tap the "Not on mobile?" button to display a QR code that can be
scanned with your mobile device.

During the account creation process you will choose a username and
password. Your Snikket address will be `<your username>@<your domain>`.
You can use this address and password to log into the web administration
page for the service.
