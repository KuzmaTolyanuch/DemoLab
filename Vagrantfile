# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.provider :virtualbox do |box|
      box.linked_clone = true
      box.customize [ "modifyvm", :id, "--memory", "1024", "--cpus", "1" ]
  end
  
  config.vm.define :jenkins do |box|
      box.vm.hostname = "jenkins"
      box.vm.box = "ubuntu/xenial64"
      box.vm.network "public_network", ip: "192.168.100.10"
      box.vm.synced_folder ".", "/mnt/host_machine"
    
      box.vm.provision :shell,
          :path => "provision-jenkins.sh",
          :args => "master", 
          :preserve_order => true,
          :run => "always"
  end
  
    config.vm.define :devenv do |box|
      box.vm.hostname = "devenv"
      box.vm.box = "ubuntu/xenial64"
      box.vm.network "public_network", ip: "192.168.100.11"
      box.vm.synced_folder "/dev", "/mnt/host_machine"
    
      box.vm.provision :shell,
          :path => "provision-dev.sh",
          :args => "master", 
          :preserve_order => true,
          :run => "always"
  end
  
      config.vm.define :stageenv do |box|
      box.vm.hostname = "stageenv"
      box.vm.box = "ubuntu/xenial64"
      box.vm.network "public_network", ip: "192.168.100.12"
      box.vm.synced_folder "/stage", "/mnt/host_machine"
    
      box.vm.provision :shell,
          :path => "provision-stage.sh",
          :args => "master", 
          :preserve_order => true,
          :run => "always"
  end
  
      config.vm.define :qaenv do |box|
      box.vm.hostname = "qaenv"
      box.vm.box = "ubuntu/xenial64"
      box.vm.network "public_network", ip: "192.168.100.13"
      box.vm.synced_folder "/qa", "/mnt/host_machine"
    
      box.vm.provision :shell,
          :path => "provision-qa.sh",
          :args => "master", 
          :preserve_order => true,
          :run => "always"
      end
end
