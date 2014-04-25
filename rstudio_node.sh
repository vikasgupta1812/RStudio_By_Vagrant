#!/bin/bash

$(which mysql > /dev/null 2>&1)
FOUND_MYSQL=$?
if [ "$FOUND_MYSQL" -ne '0' ]; then
  echo 'Attempting to install mySQL.'
  apt-get update
  #apt-get install -f -y pwgen >/dev/null; 
  #MYSQL_PASS=$(pwgen -s 12 1); 
  #cat <<MYSQL_PRESEED | debconf-set-selections
  #mysql-server-5.1 mysql-server/root_password password $MYSQL_PASS 
  #mysql-server-5.1 mysql-server/root_password_again password $MYSQL_PASS 
  #mysql-server-5.1 mysql-server/start_on_boot boolean true MYSQL_PRESEED 

  sudo DEBIAN_FRONTEND=noninteractive apt-get install -f -y mysql-server 

  #echo "MySQL Password set to '${MYSQL_PASS}'. Remember to delete ~/.mysql.passwd" | tee ~/.mysql.passwd
  # - See more at: http://ajohnstone.com/achives/installing-java-mysql-unattendednon-interactive-installation/#sthash.DI5V5anA.dpuf;

  # Additional notes after install: 
  # Place on a public interface 
  sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf 
  sudo service mysql restart 
else
  echo 'mySQL found.'
fi
echo "Install Package RMySQL"
R -e "install.packages('RMySQL', repos='http://cran.rstudio.com/')"


$(which git > /dev/null 2>&1)
FOUND_GIT=$?
if [ "$FOUND_GIT" -ne '0' ]; then
  echo 'Attempting to install git.'
  $(which apt-get > /dev/null 2>&1)
  FOUND_APT=$?
  $(which yum > /dev/null 2>&1)
  FOUND_YUM=$?

  if [ "${FOUND_YUM}" -eq '0' ]; then
    yum -q -y makecache
    yum -q -y install git
    echo 'git installed.'
  elif [ "${FOUND_APT}" -eq '0' ]; then
    apt-get -q -y update
    apt-get -q -y install git
    echo 'git installed.'
  else
    echo 'No package installer available. You may need to install git manually.'
  fi
else
  echo 'git found.'
fi


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
R -e "install.packages('RMySQL', repos='http://cran.rstudio.com/')"
R -e "install.github('twitteR', username='geoffjentry)"


# Update /etc/hosts with localhost so that X11 port forwarding will work.
echo "127.0.0.1	localhost" >> /etc/hosts

# Do not let this run again
touch /.vagrant_build_done
