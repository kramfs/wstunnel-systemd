#!/bin/bash -e

# CHECK IF RUNNING AS ROOT OR SUDO 
if [ "$(id -u)" != "0" ]; then
	echo "Please run as root or use sudo."
	exit 1
fi

# DOWNLOAD THE WSTUNNEL BINARY

cd /tmp
wget https://binaries.rightscale.com/rsbin/wstunnel/1.0/wstunnel-linux-amd64.tgz 
tar zxvf wstunnel-linux-amd64.tgz 
chmod -v +x wstunnel/wstunnel
sudo mv -vf wstunnel/wstunnel /usr/local/bin/
/usr/local/bin/wstunnel version
rm -Rf wstunnel/


# GENERATE CONFIG FILE

cat <<EOF> /etc/default/wstunnel.config
# Configuration for wstunnel service - place in /etc/default/wstuncli 

# Rendez-vous token: the HTTP client at the other end needs to use the same token to rendez-vous
# with the client running here. Use something secret minimum of 16 up to 31 characters!
#TOKEN=temp_jwG2gkEthvMkYO31VbFw=$
TOKEN=

# Remote websockets tunnel endpoint to which this client connects to
TUNNEL=wss://wstunnel10-1.rightscale.com

# Local server to which HTTP requests are forwarded, this is the web server to which requests
# are being tunneled. Currently only http is supported (not https).
SERVER=http://localhost

# It is possible to allow the wstunnel to target multiple hosts too. WStunnel client must be configured 
# with a regexp that limits the destination web server hostnames it allows.
# If you OpenStack Keystone host has an IP of 192.168.0.1, then use http://192\..*.
REGEXP='http://192\..*.'
EOF

# CREATE THE SYSTEMD SERVICE SCRIPT
cat <<EOF> /usr/lib/systemd/system/wstunnel.service
"[Unit]
Description=Setup wstunnel to RightScale
After=network.target
Wants=

[Service]
EnvironmentFile=/etc/default/wstunnel.config
ExecStart=/usr/local/bin/wstunnel cli -regexp \$REGEXP -token \$TOKEN -tunnel \$TUNNEL -server \$SERVER -logfile /var/log/wstuncli.log
KillMode=process
Restart=on-failure
#RestartSec=42s

[Install]
WantedBy=multi-user.target"
EOF


# RELOAD SYSTEMD
systemctl daemon-reload

# ENABLE WSTUNNEL SERVICE
systemctl enable wstunnel.service

# START THE SERVICE
systemctl start wstunnel.service