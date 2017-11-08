# Modification of file found at http://TeroKarvinen.com/

$ttscript = <<TTSCRIPT
apt update
apt install -y puppet
echo "192.168.100.12 mestari420" |sudo tee --append /etc/hosts
echo "[agent]"|sudo tee --append /etc/puppet/puppet.conf
echo "server = mestari420"|sudo tee --append /etc/puppet/puppet.conf
puppet agent --enable
service puppet restart
TTSCRIPT


Vagrant.configure(2) do |config|

	config.vm.box = "minimal/xenial64"
	config.vm.provision "shell", inline: $ttscript
(1..5).each do |i|
	config.vm.define "slave#{i}" do |slave|
		slave.vm.hostname = "slave#{i}"

	slave.vm.provider "virtualbox" do |vb|
		vb.memory = 200
		vb.linked_clone = true
        end

 end
end
end
