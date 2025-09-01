# VPS-setup
## Updates
```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install python3-full
sudo apt-get install joe
```
## Install nodered
```
bash <(curl -sL https://github.com/node-red/linux-installers/releases/latest/download/update-nodejs-and-nodered-deb)
sudo systemctl enable nodered.service
```
## Allow node to bind to port 443
```
sudo apt-get install libcap2-bin
sudo setcap 'cap_net_bind_service=+ep' `which node`
```
## Creating Self-signed Certs
Simple script to create a root ca and self-sign certs.  Install the myCA.pem in your browser.
```
mkdir ~/certs
cd ~/certs
wget https://github.com/RandomBits-top/VPS-setup/raw/refs/heads/main/mkcert.sh
```
