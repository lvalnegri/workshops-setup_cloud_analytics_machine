
  - VPS manager: [Digital Ocean](https://cloud.digitalocean.com/)
  - OS: [Ubuntu **18.04**.2 LTS]([http://releases.ubuntu.com/18.04/](http://releases.ubuntu.com/18.04/))
  - Size: 1CPU, 2GB RAM, 50GB SSD, 2TB data (to upsize later when needed)  
  - Datacenter Region: *London*
  - IP: 
  - hostname: 
  - ports: 
  - domain: [Freenom](https://www.freenom.com/)
  - usrname: 
  - ssh-key: 
  - grpname: **public**  
  - public folder: `/usr/local/share/public`
  - $R$ packages folder: `/usr/local/share/public/R_library`

### Basic Configuration

  - [ ] create machine
  - [ ] first connection: change root password (if not automatic, run  `passwd`)
  - [ ] check/change timezone
  - [ ] update/upgrade/dist-upgrade the system
  - [ ] add DO monitoring:  `curl -sSL https://agent.digitalocean.com/install.sh | sh`
  - [ ] install missing  _default_  packages:    
    ```
        apt-get install -y apt-transport-https software-properties-common dos2unix man-db ufw git-core nano libauthen-oath-perl openssh-server
    ```
  - [ ] add user(s) to system:  `adduser luca`
  - [ ] add user(s) to  _sudo_  group:  `usermod -aG sudo luca`  ==> check
  - [ ] configure  _git_  for new user(s):
    
    ```
        git config --global user.name "Luca Valnegri"
        git config --global user.email "l.valnegri@datamaps.co.uk"
    ```
    
  - [ ] add  _public_  group:  `sudo groupadd public`
  - [ ] add user(s) to group:  `sudo usermod -aG public luca`
  - [ ] add  _public_  repository
    
    ```
        sudo mkdir -p /usr/local/share/public/
        sudo chgrp -R public /usr/local/share/public/
        sudo chmod -R 2775 /usr/local/share/public/
    ```
    
  - [ ] set public repo in  `/etc/environment`  as  **PUB_PATH**
  - [ ] reboot:  `sudo reboot`
  - [ ] add subfolders  `software`  and  `scripts`  to  `home`  folder
  - [ ] add subfolders  `subs`  and  `r_packages`  to  `scripts`  subfolder
  - [ ]  `cd subs`  then download from pastebin the files  _916041fv_  as  **public_subs.sh**  and  _zbzDnuHb_  as  **public_subs.lst**:  
    `wget -O public_subs.sh https://pastebin.com/raw/916041fv`  
    `wget -O public_subs.lst https://pastebin.com/raw/zbzDnuHb`
  - [ ] convert to UNIX format:  `dos2unix public_subs.lst public_subs.sh`  or simply  `dos2unix *`
  - [ ] make  **public_subs.sh**  executable:  `chmod +x public_subs.sh`
  - [ ] run  **public_subs.sh**  to add subfolders to  _public_  repo:  `./public_subs.sh`
  - [ ] follow the same steps as above to create subfolders in the  _home_  folder:  
    `wget -O home_subs.sh https://pastebin.com/raw/XThRT4u4`  
    `wget -O home_subs.lst https://pastebin.com/raw/Ze6M1snP`
  - [ ] deny the  `root`  user direct access via SSH:  `sudo nano /etc/ssh/sshd_config`  (restart SSH + check)
  - [ ] change port to SSH:  `sudo nano /etc/ssh/sshd_config`  (restart SSH + check)
  - [ ] enable the default firewall [UFW](https://help.ubuntu.com/community/UFW):  `sudo ufw enable`  (check)
  - [ ] allow (new) SSH port:  `sudo ufw allow XYYYY`  (check)
  - [ ] install antivirus [ClamAV](https://www.clamav.net/):  
         `sudo apt-get install -y ClamAV`
  - [ ] install webmin / allow port 10000 (check, remember it's only on  `https`)
  - [ ] redirect http / change port / allow new port / delete previous port rule (check)
  - [ ] add 2FA
  - [ ] add a domain name
  - [ ] take a snapshot

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE0NDgyMjQ3OCwtNDYyODMyMTA2LC01OT
U4OTc0ODRdfQ==
-->