
rstudio_node_name = "affy-rstudio"

Vagrant.configure("2") do |config|

  config.vm.define :rstudio do |rstudio|
    rstudio.vm.box_url ="http://files.vagrantup.com/precise64.box"
    rstudio.vm.box = "precise64"
    rstudio.vm.provider :virtualbox do |v|
      v.name = rstudio_node_name
      v.customize ["modifyvm", :id, "--memory", "4096"]
      v.customize ["modifyvm", :id, "--cpus", "4"]
    end
    rstudio.vm.network :private_network, ip: "10.211.55.110"
    rstudio.vm.hostname = rstudio_node_name
    rstudio.vm.provision :shell, :path => "rstudio_node.sh"
    rstudio.ssh.forward_x11 = true
    rstudio.vm.synced_folder "C:\\Users\\vikas\\share", "/home/vagrant/share"
  end

end

