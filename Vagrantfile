# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.network "public_network", ip: "192.168.100.10"
  config.vm.synced_folder ".", "/mnt/host_machine"
  config.vm.provider :virtualbox do |vb|
      vb.name = "jenkins"
      vb.memory = "2048"
  end
  config.vm.provision "shell" do |s|
    s.path = "provision-jenkins.sh"
  end
  
  config.vm.box = "ubuntu/xenial64"
  config.vm.network "public_network", ip: "192.168.100.11"
  config.vm.synced_folder ".", "/mnt/host_machine"
  config.vm.provider :virtualbox do |vb|
      vb.name = "DevEnv"
      vb.memory = "2048"
  end
  config.vm.provision "shell" do |s|
    s.path = "provision-dev.sh"
  end
  
    config.vm.box = "ubuntu/xenial64"
  config.vm.network "public_network", ip: "192.168.100.12"
  config.vm.synced_folder ".", "/mnt/host_machine"
  config.vm.provider :virtualbox do |vb|
      vb.name = "StageEnv"
      vb.memory = "2048"
  end
  config.vm.provision "shell" do |s|
    s.path = "provision-stage.sh"
  end
  
     config.vm.box = "ubuntu/xenial64"
  config.vm.network "public_network", ip: "192.168.100.13"
  config.vm.synced_folder ".", "/mnt/host_machine"
  config.vm.provider :virtualbox do |vb|
      vb.name = "QAEnv"
      vb.memory = "2048"
  end
  config.vm.provision "shell" do |s|
    s.path = "provision-qa.sh"
  end 
end
