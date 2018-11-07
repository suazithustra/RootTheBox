# This is the most bare-bones-as-fuck version of a VagrantFile
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.provision "shell", privileged: false, path: "provisioner.sh"
  config.vm.synced_folder ".", "/home/vagrant/RootTheBox"
  config.vm.network "forwarded_port", guest: 8888, host: 8080
end
