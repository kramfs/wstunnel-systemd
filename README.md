# wstunnel-systemd
Download wstunnel and setup systemd style service script

Clone
-------------
`git clone https://github.com/kramfs/wstunnel-systemd.git`

Customize the required inputs
-------------
`cd wstunnel-systemd`

`chmod +x wstunnel-systemd.sh`

`vi wstunnel-systemd.sh`

Edit the following, replace the value. 
> TOKEN=``
> REGEXP=``

For the TOKEN, use something secret minimum of 16 up to 31 characters, i.e TOKEN=`temp_jwG2gkEthvMkYO31VbFw=$`
As for the REGEXP, if the Keystone host has an IP of 192.168.0.1, then use REGEXP='http://192\..*.'


Run the script
-------------
`sudo ./wstunnel-systemd.sh`
