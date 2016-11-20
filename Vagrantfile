# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "bento/centos-7.2"

  config.vm.provider "vmware_fusion" do |v|
	v.vmx["memsize"] = "4096"
	v.vmx["numvcpus"] = "2"
  end
  
  config.vm.hostname = "spark2.home.lab"
  config.vm.provision "shell", path: "scripts/setup-centos.sh"
  config.vm.provision "shell", path: "scripts/setup-jdk.sh"
  config.vm.provision "shell", path: "scripts/setup-hadoop.sh"
  config.vm.provision "shell", path: "scripts/setup-hive.sh"
  config.vm.provision "shell", path: "scripts/setup-spark.sh"
  config.vm.provision "shell", path: "scripts/finalize-centos.sh"
end
