
rstudio_node_name = "affy-rstudio"

Vagrant.configure("2") do |config|

  config.vm.define :rstudio do |rstudio|
    rstudio.vm.box_url ="http://nitron-vagrant.s3-website-us-east-1.amazonaws.com/vagrant_ubuntu_12.04.3_amd64_virtualbox.box"
    rstudio.vm.box = "ubuntu-12.04.3"
    rstudio.vm.provider :virtualbox do |v|
      v.name = rstudio_node_name
      v.customize ["modifyvm", :id, "--memory", "4096"]
      v.customize ["modifyvm", :id, "--cpus", "4"]
    end
    rstudio.vm.network "forwarded_port", guest: 8787, host: 8787
    rstudio.vm.hostname = rstudio_node_name
    rstudio.vm.provision :shell, :path => "rstudio_node.sh"
    rstudio.ssh.forward_x11 = true
    rstudio.vm.synced_folder "C:\\Users\\vikas\\share", "/home/vagrant/share"
  end

end

