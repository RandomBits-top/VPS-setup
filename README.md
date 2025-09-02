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
## Cheap DNS
* Suggest Cloudfare (they do registration at cost) or Porkbun (they have a few TLDs that cloudflare doesn't support)
  * Look at .top as a cheap TLD (i.e. < $5/yr @ renewal)
  * Watch for cheap 1st year discounts and steep renewals!
* Look at cloudflare tunnels for securing traffic to your VPS.   You can use with any registrar/DNS provide that supports adding NS records.
## Simple Webhosting
* A public github with a README.md makes a very simple way to document something
* Github pages, which allows customer domains for free, will auto convert to a webpage withour the github interface.
* You can use A records on your root domain, or even easier subdomains can be CNAME'd to your github page
* Best for single page sites

  
    
