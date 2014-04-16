R and RStudio by Vagrant
=======================

Start a single Ubuntu Precise (12.04) node containing R and RStudio that responds to web requests.

1. Install Vagrant
2. Download this project.
3. Add the following to your /etc/host file.

10.211.55.110	affy-rstudio

4. Run 'Vagrant up'

Now you can visit the following URLs in your browser and login:

     URL: http://affy-rstudio:8787/
     User: rstudio
     Password: password

2014-04-16 - Google Chrome has stopped working to display the site. However, Firefox is working fine.

You can SSH to the node using the following command. Notice that the hostname starts with 'affy-' but that 
the vagrant node does not have the prefix.

vagrant ssh rstudio

In case it is not obvious, files created by dput() are placed into the /home/rstudio directory on the virtual 
machine. The file systems look like this:

vagrant@affy-rstudio:~$ df -h
Filesystem                  Size  Used Avail Use% Mounted on
/dev/mapper/precise64-root   79G  2.7G   73G   4% /
udev                        2.0G  4.0K  2.0G   1% /dev
tmpfs                       791M  276K  791M   1% /run
none                        5.0M     0  5.0M   0% /run/lock
none                        2.0G     0  2.0G   0% /run/shm
/dev/sda1                   228M   25M  192M  12% /boot
/vagrant                    466G  241G  225G  52% /vagrant

Your files are placed here:

Filesystem                  Size  Used Avail Use% Mounted on
/dev/mapper/precise64-root   79G  2.7G   73G   4% /

At 80G you should have plenty of room to process data sets.

----------------
- Shiny
----------------

2014-Apr-15 The project was updated to install Shiny. In the console, run the following to see an example application:

     library(shiny)
     runExample("01_hello", port=9876, host='10.211.55.110')

----------------
- RMarkdown
----------------

The installation process to install RMarkdown is too length for me to include directly because, perhaps, not everyone needs it. However, here are the installation steps:

     # install the Glasgow Haskell Compiler
     sudo apt-get install -y build-dep freeglut3 freeglut3-dev libcurl4-gnutls-dev libgmp3c2 libgmp3-dev 
     wget http://www.haskell.org/ghc/dist/7.6.3/ghc-7.6.3-x86_64-unknown-linux.tar.bz2
     bunzip2 ghc-7.6.3-x86_64-unknown-linux.tar.bz2
     tar xvf ghc-7.6.3-x86_64-unknown-linux.tar
     cd ghc-7.6.3
     ./configure
     sudo make install

     # install the Haskell Platform
     wget http://www.haskell.org/platform/download/2013.2.0.0/haskell-platform-2013.2.0.0.tar.gz
     tar xvfz haskell-platform-2013.2.0.0.tar.gz
     cd haskell-platform-2013.2.0.0
     ./configure
     make
     sudo make install

     # Update Haskell packages
     cabal update
     # Get latest version of Cabal
     cabal install cabal-install

     # Install the latest Pandoc
     cabal install pandoc pandoc-citeproc

     # check that you can ran pandoc
     pandoc -v
     # otherwise create a symlink
     sudo ln -s /home/vagrant/.cabal/bin/pandoc /usr/bin/pandoc

Then run the following inside RStudio:

     install.packages('knitr')
     install.packages("devtools")
     devtools::install_github("rstudio/rmarkdown")

And finally you can use File > New File > R Markdown and develop your RMarkdown file.

