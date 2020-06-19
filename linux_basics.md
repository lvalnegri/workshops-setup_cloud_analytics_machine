
## Terminal

  - `clear` (**CTRL+L**) to clear the screen 
  - `exit` close the current session

### Personalize the prompt
The **prompt** is the string that greets the user every time the system is waiting for input. In Ubuntu, it is usually defined as 
```
usrname@hostname:current_directory$ 
```
for *standard* users, or 
```
root@hostname:current_directory# 
```
for the **root** user or *sudoers*. 

To change the appearance of the prompt is sufficient to redefine the environment variable `PS1` as in:
```
PS1 'promptstring'
```
where `promptstring` can contain, besides any text, one or more of the following **escape sequences**:   
  - `\h` hostname, up to the first dot
  - `\H` full hostname
  - `\u` username of the current user
  - `\W` current working directory (partial path, $HOME is abbreviated as `~`)
  - `\w` current working directory (full path, $HOME is abbreviated as `~`)
  - `\d` current date in "Weekday Month Day" format
  - `\D{format}` current date in the specified format (and parsed by `strftime(3)`)
  - `\t` current time in 24-hour HH:MM:SS format
  - `\T` current time in 12-hour HH:MM:SS format
  - `\@` current time in 12-hour AM/PM format
  - `\A` current time in 24-hour HH:MM format
  - `\n` newline
  - `\r` carriage return
  - `\\` a backslash
  - `\nnn` the character corresponding to the octal number nnn
  - `\e` an ASCII escape character (033)
  - `\[` begin a sequence of non-printing characters, which could be used to embed a terminal control sequence into the prompt
  - `\]` end a sequence of non-printing characters
  - `\#` command number of the current command
  - `\!` the history number of the current command
  - `\j` the number of jobs currently managed by the shell
  - `\a` an ASCII bell character (07)

It's also possible to include the result of any command (be careful here!) using *backticks* to include it wherever in the `promptstring`. 

Notice that when a user wants to display lots of information, but wants anyway to keep the prompt short and unobstrusive, one strategy is to divide that information between two or more lines using the newline character `\n `. While many people dislike a multi-line prompt, it is often the only way to provide more information in the prompt.

The change of the `PS1` variable will take effect immediately, but will be abandoned when that terminal session is ended. To change it permanently you need to change your personal configuration file `~/.bashrc`.
  - First save a backup copy, just in case
	```
	cp ~/.bashrc ~/.bashrc-backup 
	```
  - then open it for editing:
	```
	nano ~/.bashrc 
	```
  - and find the section that starts with:
	```
	if [ "$color_prompt" = yes ]; then
	```
  - once located, comment the code inside the `else` part, and add below it the chosen `promptstring`
  - save and exit.

It's also possible to add colours, though it's a bit excruciating if done by the book. But you can actually copy the following snippet:
```
# ANSI color codes
RS="\[\033[0m\]"    # reset
HC="\[\033[1m\]"    # hicolor
UL="\[\033[4m\]"    # underline
INV="\[\033[7m\]"   # inverse background and foreground
FBLK="\[\033[30m\]" # foreground black
FRED="\[\033[31m\]" # foreground red
FGRN="\[\033[32m\]" # foreground green
FYEL="\[\033[33m\]" # foreground yellow
FBLE="\[\033[34m\]" # foreground blue
FMAG="\[\033[35m\]" # foreground magenta
FCYN="\[\033[36m\]" # foreground cyan
FWHT="\[\033[37m\]" # foreground white
BBLK="\[\033[40m\]" # background black
BRED="\[\033[41m\]" # background red
BGRN="\[\033[42m\]" # background green
BYEL="\[\033[43m\]" # background yellow
BBLE="\[\033[44m\]" # background blue
BMAG="\[\033[45m\]" # background magenta
BCYN="\[\033[46m\]" # background cyan
BWHT="\[\033[47m\]" # background white
```
and paste it before the `if` block, and then you can insert colours in the string definition for `PS1` using something like `$BWHT` instead of its ANSI counterpart `\[\033[47m\]`, to indicate a **background white**.



## Help

  - `man `



## Date and Time

  - `date` check the system date and time, with timezone
  - `timedatectl` 
  - `date +%Y%m%d -s "yyyymmdd"` set the system date
  - `date +%T -s "hh:mm:ss"` set the system time
  - `sudo dpkg-reconfigure tzdata` reconfigure the timezone of the system clock 
  - `sudo hwclock --show` check the hardware clock
  - `sudo hwclock --set --date="yyyy-mm-dd hh:mm:ss" --localtime` set the hardware clock to the local time

## Folders structure

  - `/` (root of the system)
  - `bin` Essential commands
  - `boot` Boot loader files, Linux kernel
  - `cdrom`
  - `dev` Device files (notice that in Linux everything is a file)
  - **`etc`** System configuration files, almost everything on how to do things in Linux is stored here
  - **`home`**  host the repositories for all users different from root. Notice that `~` represents the home directory of the *current* user, so that `~` points in general towards different directories according to the user logged in.
  - `lib` Shared libraries, kernel modules
  - `lib64`
  - `lost+found` Directory for recovered files (if found after a file system check)
  - `media` Mount point for removable media
  - `mnt` Mount point for local, remote file systems
  - `opt` Add-on software packages
  - `proc` Kernel information, process control
  - `root` Super-user (root) home
  - `run` 
  - `sbin` System commands (mostly root only)
  - `snap` 
  - `srv` Holds information relating to services that run on your system
  - `sys` Real-time information on devices used by the kernel
  - `tmp` Temporary files
  - `usr` Secondary software file hierarchy
  - **`var`** Variable data, spooled files, they can grew indefinitely so they should kept under control
    - `log` store all logs for all apps and services
    - `ftp`
    - `www`
	  - `html` Apache web server's initial home page directory for the system

## Managing Files and Folders

  - Names and commands are case sensitive

  - `.` the current directory
  - `..` the parent directory of the current directory
  - `/` the **root** directory (notice that the home directory of the **root** user is `/root`)
  - `~` the **home** directory of the current user, or `/home/usrname/`
  - `-` the *previous* directory, if it exists

  - `pwd` returns the full path of the current directory

  - `cd [path]` allows to navigate through the file system
	- `cd`, `cd ~` and `cd $HOME` all return to the current user home directory 

  - `rm /path/to/file`
	- `rm -f `
	- `rm -r `
  - `mkdir path` create a new directory
  - `rmdir path` 
	- `rmdir -r path`
  - `shred`


  - `ls [path]` to list files and folders located in the current directory or in the specified path
	- `ls -l` 
	- `ls -a` also returns hidden files
	- `ls -R` use a recursive scan into all sub-directories. If you know it'll be a lot of information, or just to stay on the safe side, you may want to redirect the output to a text file (see below) 

  - `cp` copy files
  - `mv` move or rename files
  - `scp` secure copy between different servers

  - `cat filename` print the content of any file
	- `cat -n` numbers the lines in the output
	- `cat -s` prints a maximum of one blank line at a time, that's any contiguous multiple blank lines in the input are translated in a single blank line i the output. Notice that combining `-s` and `-n`, in the output the numbers relate only to the lines that are actually printed 
	- `cat fname1 fname2 ...` print the content of all the specified files chained together as a single file
  - `touch`
  - `less filename` filters for paging through output
  - `tail filename` prints the last lines of a file
  - `sort filename` prints the contents of a file in the specified order

  - `nano filename` basic editor for text files 
  - `emacs filename` powerful editor for text files
  - `vim filename` powerful editor for text files

  - `grep`

  - `apropos`
  - `find`
  - `which prgname` prints the location of a command
  - `locate` find files from an index

  - `ln` creates links between files 

  - `wget url` download files using HTTP, HTTPS, and FTP protocols
	- `wget -O filename url` save the downloaded file as `filename`
	- `wget -m url` mirror the content of 
  - `curl `


  - `tar` 
	- `tar -x` 
	- `tar -z` 
	- `tar -v` 
	- `tar -f` 
  - `gzip`  

  - `bash`


### Piping, Redirections

  - `>`

  - `>>`

  - `|`



## Users and Groups, Permissions, Ownership

  - the `root` user is the first user created during installation and it's the 

  - `useradd usrname`

  - `su`

  - `sudo`
	- `sudo -i`

  - `sudo passwd` to change password for the **root** user
  - `sudo passwd usrname` to change password for the user **usrname**


Apart from `root`, there are three sets of users in every Linux system:
  - the user who created the file/directory
  - the group the owner belong
  - other, meaning anyone different from the owner and the group(s)

Each user has 


To set the permissions on a file and/or directory we use the following commands:
  - `chown`
  - `chmod` change file and directories access permissions
  - `chgrp`

## Package management

  - what's `apt` / 
  - what's `dpkg`

  - `apt-cache search `
  - `apt-cache show pkgname`
  - `sudo apt-get update`
  - `sudo apt-get upgrade`
  - `sudo apt-get dist-upgrade`
  - `sudo apt-get install pkgname`
  - `sudo apt-get remove pkgname`
  - `sudo apt-get autoremove`
  - `sudo apt-get clean`
  - `apt -qq list` list all packages installed in the system
  - `apt -qq list <pkgname>` or `dpkg -l <pkgname>` checks if the package `<pkgname>` is already installed

  - `dpkg -l` list everything installed in the system 

  - `make` Compiles and installs program from source
 
 
## Services

  - `top`
  - `ps -acx`
  - `kill pid`
  - `service --status-all` list all installed services, and if they are running or not  
  - `sudo /etc/init.d/srvname start` or `sudo service srvname start`
  - `sudo /etc/init.d/srvname stop` or `sudo service srvname stop`
  - `sudo /etc/init.d/srvname restart` or `sudo service srvname restart`
  - ``

  - `less /etc/services` list all ports used by *standard* services


## Firewall

All the following commands must be run with `root`/`sudo` admin rights:
  - `ufw enable`
  - `ufw disable`
  - `ufw reset`
  - `ufw status`
	- `ufw status verbose`
  - `ufw allow XXXX`
  - `ufw allow app list`
  - `ufw allow app_profile` where `app_profile` must be present in the above list. Some default profiles present are: `ssh`, `http`, `https`, `ftp`
  - `ufw allow XXXX/tcp`
  - `ufw allow XXXX/udp`
  - `ufw allow XXXX:YYYY`
  - `ufw allow from www.xxx.yyy.zzz`
	- `ufw allow from www.xxx.yyy.zzz to port`
	- `ufw allow from www.xxx.yyy.zzz to any port`
  - `ufw show added`
  - `ufw delete allow XXXX`


## Monitoring

  - `du` print disk usage
  - `free` print information about RAM
  - `watch free`
  - `watch sensors` (if not present run: `sudo apt-get install `)
  - ``
 
### Check Internet Speed with speedtest
   
  - Install pre-requisite *pip*:
	```
	sudo apt-get install python-pip
	```

  - Install the app:
	```
	sudo pip install speedtest-cli 
	speedtest-cli
	```

  - To upgrade the speedtest-cli application in future:   
	```
	pip install speedtest-cli â€“-upgrade
	```

  - It's possible to create an internet speed log by simply scheduling a *cron job* (see below) to the system, adding the following line in the crontab file:
	```
	min hour dom mon dow  /usr/local/bin/speedtest-cli >> /tmp/speedlog.txt
	```
	where `min`, `hour`, `dom`, `mon`, `dow` should be replaced with the appropriate desired values, and assuming that the script `speedtest_cli.py` is installed in `/usr/local/bin`.




## Scheduling 
The package *cron* allows Linux users to run commands or scripts at a given date and/or time, or periodically at given dates and/or times. Cron is one of the most useful tool in a Linux OS, notably for sysadmin jobs such as backups or cleaning /tmp/ directories.

  - `crontab -u usrname -e`
 
The general format of a line in the crontab file is the following:
```
{minute} {hour} {day-of-month} {month} {day-of-week} {user} {/path/to/shell-script}
```

Every line consists in a call to a command or scripts, where the first five arguments should be in order:
  - minute(s) when the process will be started [0-59]
  - hour(s)  when the process will be started [0-23]
  - day(s) of the month  when the process will be started [1-31]
  - month(s)  when the process will be started [1-12], or [JAN-DEC]
  - day(s) of the week  when the process will be started [0-6], or [SUN-SAT] (Note here that Sunday can actually be specified with a 7)

Additionally, there are some general options valid for all the temporal arguments:

  - `*` any value
  - `*/n` every n period
  - `,` value list separator
  - `-` range of values

See [here](https://crontab.guru/examples.html) for many real cases examples.

It's important to keep in mind that cronjobs can actually fail. To monitor a cronjob ...


## bash programming



## Measuring Performance / Benchmarking



## Variables


## Remote Access

### SSH

### Telnet

### VNC


## Desktop Environment over Ubuntu Server

see [this](https://askubuntu.com/questions/53822/how-do-you-run-ubuntu-server-with-a-gui) post

  - `sudo apt-get install ubuntu-desktop` install the default Unity desktop environment: 

  - `sudo aptitude install --without-recommends ubuntu-desktop` install the Unity desktop without addons (email, OpenOffice, ...) 

  - `sudo apt-get install xubuntu-desktop` install [XFCE]() a very lightweight desktop environment, just the basic GUI

  - `sudo apt-get install lubuntu-desktop` : install [LXDE]() an even lighter GUI

  - ``

  - ``


<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE1Mzk4NTY5MjFdfQ==
-->