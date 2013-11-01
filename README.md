R and RStudio by Vagrant
=======================

Start a single Ubuntu Precise (12.04) node containing R and RStudio that responds to web requests.

1. Install Vagrant
2. Download this project.
3. Add the following to your /etc/host file.

10.211.55.110	affy-rstudio

4. Run 'Vagrant up'

Now you can visit the following URLs in your browser:

http://affy-rstudio:8787/

Log into the web application using 'rstudio' as the username and 'password' as the password.

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
