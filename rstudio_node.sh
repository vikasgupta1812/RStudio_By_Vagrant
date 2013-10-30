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

apt-get update
apt-get install -y r-base gdebi-core libapparmor1

wget -q http://download2.rstudio.org/rstudio-server-0.97.551-amd64.deb

gdebi -n rstudio-server-0.97.551-amd64.deb

# Do not let this run again
touch /.vagrant_build_done
