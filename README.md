# snikket-selfhosted
Setup and resources for self-hosting your Snikket service!

## Setup instructions

### Step 1: Fetch the source

```
cd /opt
git clone https://github.com/snikket-im/snikket-selfhosted snikket
```

### Step 2: Configure

An automatic configuration script is included:

```
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
