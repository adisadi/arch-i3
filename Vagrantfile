# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
   config.ssh.forward_agent = true
   config.vm.box = "archlinux/archlinux" # from their official repository
   config.vm.disk :disk, size: "150GB", primary: true
   config.vm.provider "virtualbox" do |vb|
     # show console
     vb.gui = true
     # RAM
     vb.memory = 4096
     # CPU
     vb.cpus = 2

     #vb.name = ENV['ARCHI3_VM_NAME'] + "-" + ENV['ARCHI3_VM_VERSION']

     vb.customize ['modifyvm', :id, '--graphicscontroller', 'vmsvga']
     vb.customize ['modifyvm', :id, '--vram', '128']
     vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
   end

   if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.no_install  = true
   end
 
   config.vm.provision "shell", path: "./scripts/install-tools.sh", name: "install tools", privileged: false, reboot: true

end