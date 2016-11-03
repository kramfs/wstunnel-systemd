# Description
Download wstunnel and setup systemd style service script. This assume the wstunnel service will run in the keystone server.

Clone
-------------
`git clone https://github.com/kramfs/wstunnel-systemd.git`

Customize the inputs
-------------
`cd wstunnel-systemd`

`chmod +x wstunnel-systemd.sh`

`vi wstunnel-systemd.sh`

Edit the following adding the required inputs. 
> TOKEN=``

> REGEXP=``

> TUNNEL=``

For the TOKEN, use something secret minimum of 16 up to 31 characters, i.e TOKEN=`temp_jwG2gkEthvMkYO31VbFw=$`

As for the REGEXP, if the Keystone host has an IP of 192.168.0.1, then use REGEXP='http://192\..*.'

Setup the environment
-------------
`sudo ./wstunnel-systemd.sh`

Start the script
-------------
`sudo systemctl start wstunnel.service`
