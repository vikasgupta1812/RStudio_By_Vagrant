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

sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
echo "deb http://lib.stat.cmu.edu/R/CRAN//bin/linux/ubuntu precise/" | sudo tee -a /etc/apt/sources.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

apt-get update
apt-get install -y r-base gdebi-core libapparmor1

wget -q http://download2.rstudio.org/rstudio-server-0.98.501-amd64.deb

gdebi -n rstudio-server-0.98.501-amd64.deb

# Do not let this run again
touch /.vagrant_build_done
