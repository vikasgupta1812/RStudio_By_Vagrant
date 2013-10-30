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
