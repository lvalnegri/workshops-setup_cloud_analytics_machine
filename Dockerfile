# Download base image ubuntu 20.04
FROM ubuntu:20.04
 
RUN \
    # Update software repository
    apt-get update \
    # Install missing basic commands
    && apt-get install -y --no-install-recommends apt-utils  \
    && apt-get install -y sudo wget gdebi-core libapparmor1  \
    # Upgrade system
    && apt-get upgrade -y  \
    # Install R packages dependencies
    && apt-get install -y  \
        curl  \
		libssl-dev  \ 
        libcurl4-gnutls-dev  \
		libssl-dev  \
		libxml2-dev  \
        libcairo2-dev  \
        libxt-dev  \
		pandoc  \
        pandoc-citeproc  \
        xtail \
    # cleaning
    && apt-get clean  \
    && rm -rf /var/lib/apt/lists/  \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
    
RUN \ 
    # add CRAN repository to apt
    echo "deb http://cran.rstudio.com/bin/linux/ubuntu focal/" | sudo tee -a /etc/apt/sources.list  \
    # add public key of CRAN maintainer
    && gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9  \
    && gpg -a --export E084DAB9 | sudo apt-key add -  \
    # Update software repository
    && sudo apt-get update  \
    # install R
    && sudo apt-get install -y r-base r-base-dev  \
    # install shiny package
    && su - -c "R -e \"install.packages('shiny', repos='https://cran.rstudio.com/')\""

RUN \
    # download and install RStudio Server
    wget -O rstudio https://s3.amazonaws.com/rstudio-ide-build/server/trusty/amd64/rstudio-server-1.2.830-amd64.deb  \
    && gdebi rstudio  \
    && rm rstudio  \
    # download and install Shiny Server
    && wget -O shiny https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.7.907-amd64.deb  \
    && gdebi shiny  \
    && rm shiny
    
# Copy shiny configuration files into the Docker image (change the port ? the user ? the app directory ?)
# COPY shiny-server.conf /etc/shiny-server/shiny-server.conf

# install R packages using R script (plus cleaning)
# RUN Rscript -e "install.packages()" \
#    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

RUN \
    adduser shiny  \
    # add a new group "public"
    && groupadd public  \
    # add "shiny"" to the "public" group
    && usermod -aG public shiny  \
    # Create a new directory as a base for the shared directory with the host and modify permissions to be used by the "public" group
    && mkdir -p /usr/local/share/public  \
    && chgrp -R public /usr/local/share/public/  \
    && chmod -R 2775 /usr/local/share/public/

# Volume configuration
VOLUME ["/usr/local/share/public"]

# Add the "public" path to the R configuration file 
# RUN 

# Make RStudio and Shiny Servers available at their default ports
EXPOSE 8787 3838

# Copy executable to start Shiny Server when the container start (remember to make the file executable <chmod +x shiny-server.sh>)
COPY shiny-server.sh /usr/bin/shiny-server.sh
CMD ["/usr/bin/shiny-server.sh"]
 
