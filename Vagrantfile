# Modification of file found at http://TeroKarvinen.com/

$ttscript = <<TTSCRIPT
apt update
apt install -y puppet
echo "10.0.2.15 master" |sudo tee --append /etc/hosts
echo "[agent]"|sudo tee --append /etc/puppet/puppet.conf
echo "server = master"|sudo tee --append /etc/puppet/puppet.conf
puppet agent --enable
service puppet restart
TTSCRIPT


Vagrant.configure(2) do |config|
 config.vm.box = "minimal/xenial64"
 config.vm.provision "shell", inline: $tscript

 config.vm.define "slave01" do |slave01|
   slave01.vm.hostname = "slave01"
 end

 config.vm.define "slave02" do |slave02|
   slave02.vm.hostname = "slave02"
 end
end
