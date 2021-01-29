# How to install *R*, *RStudio Server* and *Shiny Server* on a *Raspberry Pi 4*

  * [Set up OS](#setup)
  * [R](#rstats)
  * [Shiny Server](#shiny)
  * [RStudio Server](#rstudio)
  * [Nginx](#nginx)
  * [Credits](#credits)


<a name="setup"/>

## Set up OS
 - Raspberry Pi 4B 4GB or 8GB [PiHut](https://thepihut.com/products/raspberry-pi-4-model-b?variant=20064052674622&src=raspberrypi) [Pimoroni](https://shop.pimoroni.com/products/raspberry-pi-4?variant=29157087412307) [OKDO](https://www.okdo.com/p/raspberry-pi-4-model-b-2gb-2/) [SB Components](https://shop.sb-components.co.uk/products/raspberry-pi-4-model-b?variant=29217503314003) [CPC](https://cpc.farnell.com/raspberry-pi/rpi4-modbp-2gb/raspberry-pi-4-model-b-2gb/dp/SC15184)
 - Power Supply or Power Bank 5V **with 3A output**. If you go for a portable battery, I'd suggest [this one](https://www.amazon.co.uk/gp/product/B07K1XTXRS/) that let me complete the entire process on a single full charge.
 - wired keyboard
 - [micro SD card](https://www.amazon.co.uk/SanDisk-Extreme-microSDXC-Adapter-Performance/dp/B06XWMQ81P/): 32+ Gb, fast, possibly new (do not use an old spare one found somewhere in the back of a drawer)
 - cable HDMI to [microHDMI](https://www.amazon.co.uk/AmazonBasics-speed-latest-standard-meters/dp/B014I8U33I?th=1). If you already have an HDMI-HDMI cable, you can buy an [adapter](https://www.amazon.co.uk/UGREEN-Adapter-Support-Connectors-Tablets-Black/dp/B00B2HORKE/)
 - an ethernet cable to wire up internet connection during the set up process (unfortunately, the wifi connection with ubuntu 20.04 on a pi4 is still a problematic issue).
 - [balenaEtcher](https://www.balena.io/etcher) or [Raspberry pi imager](https://www.raspberrypi.org/software/) to burn any available Raspberry Pi OS image onto the SD card.
 - [Ubuntu Server 20.04.1 LTS 64 bit](https://ubuntu.com/download/raspberry-pi) for Raspberry Pi 4

Run the imager, choose your image file and sd card, then write the OS.

Eject the card from the machine, and put it into the Rpi, attach ethernet cable, HDMI cable, keyboard cable, and finally power cable, then put the kettle on and wait for the system to do its magic.

Once the system starts, you should wait for a while before proceeding, as the system upgrades itself in the background, and you want to avoid to mess up with it. The first time you log in (user: ubuntu, pwd: ubuntu) you'll be asked to change the password. You could run `htop` to have a hint on the stautus of the upgrades, you should be clear to go when you don't see any `unattended-upgrade` in the list of running processes.

Once updates are done, run `ifconfig` to have a look at the dynamic ip address that your Rpi has been assigned. Take a note of it, and if you prefer to work from another device on your local network, instead of the keyboard and wired tv/monitor, fire up the terminal, or if you're on windows an ssh client like [putty](https://www.chiark.greenend.org.uk/~sgtatham/putty/) or [MobaXterm](https://mobaxterm.mobatek.net/), and connect using the ip address just found and the standard port 22. If something does not work, try to run the following:
```
sudo systemctl enable --now ssh
sudo systemctl status ssh
```

Once you're ready, run the following to update the system:

```
sudo apt update
sudo apt -y full-upgrade
sudo apt -y install net-tools ssh ufw dirmngr gnupg apt-transport-https ca-certificates software-properties-common \
                    build-essential nano dos2unix man-db git-core libgit2-dev libauthen-oath-perl openssh-server libsocket6-perl
# sudo ufw enable                  # ==> if you plan to put your Rpi on the public internet this is the minimum security move
# sudo ufw allow 22                # ==> when ufw has been enabled, this open the standard ssh port
# sudo passwd                      # ==> root has no password by default
# sudo nano /etc/ssh/sshd_config   # ==> if you plan to put your Rpi on the public internet you should change ssh port and set "PermitRootLogin" to no or install ssh key pair
```

To use a static IP address, we need to conveniently edit the *netplan* configuration file. We need first to identify the name of the interface to configure. The ethernet is usually called `eth0`, while the wifi `wlan0`, but run the `ip link` command to be assured.

Now we need to look into the `/etc/netplan/` directory. If there's a file called `50-cloud-init.yaml` we need first to disable it. To do so, create the following file:
```
sudo nano /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg
``` 
with the following content:
```
network: {config: disabled}
```

We can now create, or edit, the correct file:
```
sudo nano /etc/netplan/01-netcfg.yaml
```
adding the text below. Change address and gateway4 using the ones that work for you. I've used google namerservers, but you can use any other you prefer.

Align exactly using only spaces, not tabs, and always the same amount of spaces for each indent level. 

Until Canonical solve the wifi issue, it's useless to add all the `wifis` part, so for now let it out.

```
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        - 192.168.0.101/24
      gateway4: 192.168.0.1
      nameservers:
        addresses: [8.8.8.8, 8.8.8.4]
  wifis:
    wlan0:
      dhcp4: false
      addresses:
        - 192.168.0.101/24
      gateway4: 192.168.0.1
      nameservers:
        addresses: [8.8.8.8,8.8.4.4]
      access-points:
        "insert-name-here":
          password: "insert-password-here"
```

Once finished, create and apply the new configuration:
```
sudo netplan generate
sudo netplan apply
```
then check the outcome:
```
ip addr show dev wlan0
```

In case you mess up, this is the default configuration:
```
network:
  ethernets:
    eth0:
      dhcp4: true
      optional: true
  version: 2
```


<a name="rstats"/>

## R
As of Jan 2021, there are no precompiled binaries of the latest *R* version for hardwares built on ARM chips. So we need to compile from source. Look at the [CRAN](https://cran.r-project.org/) website for the correct link. The complete process should take about an hour.
   - install dependencies:
     ```
     sudo apt install -y g++ gfortran libbz2-dev libcairo2-dev libcurl4-openssl-dev libjpeg-dev liblzma-dev libpcre2-dev libpng-dev \
                         libreadline6-dev libssl-dev libx11-dev libxt-dev libzstd-dev make openjdk-11-jdk pandoc screen \
                         texinfo texlive texlive-fonts-extra xvfb zlib1g-dev
     ```
   - download source code and unzip:
     ```
     mkdir -p ~/software/R
     cd ~/software
     wget -O R4.tar.gz https://cran.rstudio.com/src/base/R-4/R-4.0.3.tar.gz
     tar zxvf R4.tar.gz -C R --strip-components 1
     ```
   - compile and install:
     ```
     cd R
     ./configure --enable-R-shlib --with-x --with-cairo --with-libpng --with-libtiff --with-jpeglib 
                 --enable-threads=posix --with-lapack --with-blas
     make
     sudo make install
     ```
   - check *R* can run, and that it was compiled with all the requested capabilities:
     ```
     R
     capabilities()
     q()
     ```
   - clean:
     ```
     cd ..
     rm -rf R
     ```

We now create a *public* repository with a specific "public" group, adding *ubuntu* to it. We also create a subdirectory `R_library` to use as a shared *R* packages library. You are free to change the names for the *public* group and directory and *R* repository.
```
sudo groupadd public
sudo usermod -aG public ubuntu
sudo mkdir -p /usr/local/share/public/R_library
sudo chgrp -R public /usr/local/share/public/
sudo chmod -R 2775 /usr/local/share/public/
```

We then create a global variable for the "public" path both:
 -  in the system:
    ```
    echo 'PUB_PATH="/usr/local/share/public"' | sudo tee -a /etc/environment
    ```
 -  and in *R*:
    ```
    echo '
        #####################################################
        ### ADDED BY ubuntu
        PUB_PATH = '/usr/local/share/public'
        R_LIBS_USER = '/usr/local/share/public/R_library'
        R_MAX_NUM_DLLS = 1000
        #####################################################
    ' | sudo tee -a $(R RHOME)/etc/Renviron
    ```
    You can fire up *R* and run `.libPaths()` and `Sys.getenv('PUB_PATH')` to be sure the changes applied correctly. 

You should now reboot the system for some of the above changes to take place.


<a name="shiny"/>

## Shiny Server

 - install the *shiny* package as usual using the *R* console (this process should take about half an hour).:
   ```
   R
   install.packages(c('shiny', 'rmarkdown', 'Cairo'))
   q()
   ```

 - install [cmake]([https://cmake.org/files/) (this process should take about an hour):
   ```
   mkdir -p ~/software/cmake
   cd ~/software
   wget -O CM.tar.gz https://cmake.org/files/v3.19/cmake-3.19.3.tar.gz 
   tar zxvf CM.tar.gz -C cmake --strip-components 1
   cd cmake
   ./configure
   make
   sudo make install
   cd ..
   rm -rf cmake
   ```

 - download and extract source code (have also a look at the [official instructions](https://github.com/rstudio/shiny-server/wiki/Building-Shiny-Server-from-Source)) 
   ```
   cd ~/software
   git clone https://github.com/rstudio/shiny-server.git
   cd shiny-server
   ```

 - fix *node.js* archictecture in the *RStudio* script (the CPU in the Rpi has an ARM architecture):
   ```
   wget "https://nodejs.org/dist/$(cat .nvmrc)/SHASUMS256.txt"
   SHA=$(grep "arm64.tar.xz" SHASUMS256.txt | awk -F '  +' '{print $1}') 
   sed -i -e "8s/.*/NODE_SHA256=$SHA/" -e "s/linux-x64.tar.xz/linux-arm64.tar.xz/" -e "s/https:\/\/github.com\/jcheng5\/node-centos6\/releases\/download\//https:\/\/nodejs.org\/dist\//" external/node/install-node.sh
   ```

 - install Shiny Server using the ready-made RStudio script:
   ```
   packaging/make-package.sh
   ```

 - copy shiny-server directory to system location, with a link (pandoc gets removed as we've already installed the correct ARM version system-wide):
   ```
   rm -r ext/pandoc
   cd ..
   sudo cp -r shiny-server/ /usr/local/
   sudo ln -s /usr/local/shiny-server/bin/shiny-server /usr/bin/shiny-server
   ```

 - create the *shiny* user, adding it to the "public" share group (refresh group permission to avoid reboot):
   ```
   sudo useradd -rm shiny
   sudo usermod -aG public shiny
   newgrp public
   ```

  - create log, config, and application directories:
    ```
    mkdir -p /usr/local/share/public/shiny_server/logs 
    sudo mkdir -p /srv/shiny-server
    sudo mkdir -p /var/lib/shiny-server
    sudo mkdir -p /etc/shiny-server
    ```

  - copy the configuration file from my public github repo (you're not obviously bound to it!):
    ```
    wget "https://raw.githubusercontent.com/lvalnegri/workshops-setup_cloud_analytics_machine/master/shiny-server.conf"
    sudo cp shiny-server.conf /etc/shiny-server/shiny-server.conf
    ```

  - adding an option for the *R* process run by the *shiny* user to process images:
    ```
    echo "options(bitmapType = 'cairo')" | sudo tee -a /home/shiny/.Rprofile && sudo chown shiny:shiny /home/shiny/.Rprofile
    ```

  - setup for start at boot
    ```
    cd shiny-server
    sed -i -e "s:ExecStart=/usr/bin/env bash -c 'exec /opt/shiny-server/bin/shiny-server >> /var/log/shiny-server.log 2>&1':ExecStart=/usr/bin/shiny-server:g"  config/systemd/shiny-server.service
    sed -i -e 's:/env::'  config/systemd/shiny-server.service
    sudo cp config/systemd/shiny-server.service /lib/systemd/system/
    sudo chmod 644 /lib/systemd/system/shiny-server.service
    ```

  - enable and start the *Shiny Server* service: 
    ```
    sudo systemctl daemon-reload
    sudo systemctl enable shiny-server.service
    sudo systemctl start shiny-server
    ```

  - let apps directory be manageable for the *ubuntu* user:
    ```
    cd /srv/shiny-server
    sudo chown -R ubuntu:public .
    sudo chmod g+w .
    sudo chmod g+s .
    ```

  - (optional) copy sample apps and index.html to server
    ```
    sudo cp samples/welcome.html /srv/shiny-server/index.html
    sudo cp -r samples/sample-apps/ /srv/shiny-server/
    ```

<a name="rstudio"/>

## RStudio Server

 - download and extract source code (have a look [here](https://github.com/rstudio/rstudio/releases) for the latest version) 
   ```
   cd ~/software
   wget -O rstudio.tar.gz https://github.com/rstudio/rstudio/archive/v1.4.1103.tar.gz
   mkdir RSS
   tar zxvf rstudio.tar.gz -C RSS --strip-components 1
   ```

 - install [sentry-cli](https://github.com/getsentry/sentry-cli) (this should take about 20 minutes):
   ```
   sudo curl https://sh.rustup.rs -sSf | sh
   source $HOME/.cargo/env
   sudo git clone https://github.com/getsentry/sentry-cli.git
   sudo chown -R ubuntu ./sentry-cli
   cd sentry-cli
   cargo build
   cd ..
   ```

 - install dependencies (this should take about one hour):
   ```
   sudo apt install -y ant clang debsigs dpkg-sig expect gnupg1 libacl1-dev libcap-dev libclang-6.0-dev libclang-dev \ 
                       libegl1-mesa libgl1-mesa-dev libgtk-3-0 libpam0g-dev libpango1.0-dev libpq-dev libsqlite3-dev \
                       libuser1-dev libxslt1-dev ninja-build openjdk-8-jdk rrdtool 
   cd RSS/dependencies/common/
   ./install-dictionaries       
   ./install-mathjax            
   ./install-boost
   ./install-packages
   ./install-pandoc
   sudo apt install -y npm
   ./install-npm-dependencies
   ./install-soci
   ```

 - if you use a 4GB version (the 8GB works just fine) you need to limit the Java heap size:	
   ```	
   export JAVA_TOOL_OPTIONS='-Xms256m -Xmx1g'
   ```	

 - compile using RStudio script (this should take five hours):
   ```
   cd ../../package/linux/
   export RSTUDIO_MAJOR_VERSION=1
   export RSTUDIO_MINOR_VERSION=4
   export RSTUDIO_PATCH_VERSION=1103
   # export MAKEFLAGS=-j4 
   ./make-package Server DEB
   ```

 - install the software:
   ```
   cd build-Server-DEB
   sudo apt install ./rstudio-server-1.4.1103-arm64-relwithdebinfo.deb
   ```

 - if you intend to use *RMarkdown*, add ARM *pandoc* path to *R* config file:
    ```
    echo '
        #####################################################
        ### ADDED BY ubuntu
        RSTUDIO_PANDOC = '/usr/bin/'
        #####################################################
    ' | sudo tee -a $(R RHOME)/etc/Renviron
    ```
    
 - cleaning:
   ```
   rm -rf ~/software/RSS
   ```


<a name="nginx"/>

## Web Server

 - install the Nginx web server, giving the standard user permission for the web root folder:
   ```
   sudo apt install -y nginx
   sudo chown -R www-data:ubuntu /var/www/html/
   sudo chmod -R 770 /var/www/html/
   ```

 - change ngnix default website configuration to let users access the servers without inserting port numbers:
   ```
   wget "https://raw.githubusercontent.com/lvalnegri/workshops-setup_cloud_analytics_machine/master/nginx.conf"
   sudo cp nginx.conf /etc/nginx/sites-available/default
   ```
   You are free to change and/or delete any parts in the above conf file, using `nano nginx.conf` before the copy.

If you plan to let the Rpi access the public internet, I suggest you first:
 - change the SSH port number to anything else between 1000 and 65535
 - block the possibility for the root user to login from ssh connections
 - if you chose a weak password for the *ubuntu* user, change it now!
 - add a certificate to allow secure SSL connections

Having done the above, you can now configure the correct port forwarding in your router/modem related to the local static IP address:
 - for SSH, SCP and SFTP open the port TCP/UDP 22 (or hopefully the different one you chose)
 - for HTTP open port TCP 80
 - for HTTPS open port TCP 443
Moreover, make sure you have `Block WAN traffic` disabled.

There are two more steps for an optimal configuration:
 - link your public ip address to an intelligible domain name. Configure your personal domain name to point to your DDNS service
 - attach the above domain name to a service that automatically resolves your static hostname and your dynamic public IP address.

<a name="credits"/>

## Credits
 - [RStudio Instructions](https://github.com/rstudio/rstudio/wiki/Building-Installers)
 - [Andrés Castro](https://twitter.com/Andresrcs): [Automagic Using Ansible](https://andresrcs.rbind.io/2021/01/13/raspberry_pi_server/) or [Manual Installation](https://andresrcs.rbind.io/2018/11/21/shiny_rstudio_server/), plus interesting [blog post](https://community.rstudio.com/t/setting-up-your-own-shiny-server-rstudio-server-on-a-raspberry-pi-3b/18982) on the [Rstudio Community](community.rstudio.com)
 
