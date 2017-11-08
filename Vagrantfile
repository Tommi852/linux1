Vagrant.configure(2) do |config|

	config.vm.box = "minimal/xenial64"
	config.vm.provision "shell", path: "slaver"
(1..100).each do |i|
	config.vm.define "slave#{i}" do |slave|
		slave.vm.hostname = "slave#{i}"

	slave.vm.provider "virtualbox" do |vb|
		vb.memory = 200
		vb.linked_clone = true
        end

 end
end
end
