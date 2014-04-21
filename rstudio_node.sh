#!/bin/bash

if [ -f /.vagrant_build_done ]; then
    echo "Script already run. Exiting."
    exit
fi

cat > /etc/hosts <<EOF
10.211.55.110   affy-rstudio
EOF

export PASSWORD=`openssl passwd -1 password`
addgroup rstudio
useradd -m -s /bin/bash -g rstudio rstudio -p $PASSWORD

locale-gen en_US

cp /etc/apt/sources.list /etc/apt/sources.list.bak
echo "deb http://lib.stat.cmu.edu/R/CRAN//bin/linux/ubuntu precise/" | sudo tee -a /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

apt-get update
apt-get build-dep -y libcurl4-gnutls-dev
apt-get build-dep -y libcurl4-openssl-dev
apt-get install libcurl4-openssl-dev
apt-get install -y gdebi-core
apt-get install -y libapparmor1
apt-get install -y openjdk-7-jre-headless
apt-get install -y r-base
apt-get install -y apt-file

###
# install dependencies for rgdal R package
sudo apt-get install -y libgdal1-dev gdal-bin libproj-dev


wget -q http://download2.rstudio.org/rstudio-server-0.98.501-amd64.deb
wget -q http://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.0.0.42-amd64.deb

gdebi -n rstudio-server-0.98.501-amd64.deb
gdebi -n shiny-server-1.0.0.42-amd64.deb

chmod -R 777 /usr/lib/R/library
chmod -R 777 /usr/share/R/doc

R -e "update.packages(checkBuilt = TRUE, ask = FALSE, repos='http://cran.rstudio.com/')"
R -e "install.packages('ggmap', repos='http://cran.rstudio.com/')"
R -e "install.packages('gpclib', repos='http://cran.rstudio.com/')"
R -e "install.packages('knitr', repos='http://cran.rstudio.com/')"
R -e "install.packages('maptools', repos='http://cran.rstudio.com/')"
R -e "install.packages('RCurl', repos='http://cran.rstudio.com/')"
R -e "install.packages('rgdal', repos='http://cran.rstudio.com/')"
R -e "install.packages('rgeos', repos='http://cran.rstudio.com/')"
R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"
R -e "install.packages('raster', repos='http://cran.rstudio.com/')"
R -e "install.packages('quantmod', repos='http://cran.rstudio.com/')"
R -e "install.packages('googleVis', repos='http://cran.rstudio.com/')"
R -e "install.github('twitteR', username='geoffjentry)"

# Update /etc/hosts with localhost so that X11 port forwarding will work.
echo "127.0.0.1	localhost" >> /etc/hosts

# Do not let this run again
touch /.vagrant_build_done
