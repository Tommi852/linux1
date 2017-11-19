Vagrant.configure(2) do |config|
  config.vm.box = "minimal/trusty64"
  config.vm.provision "shell", path: "slaver"
  config.vm.usable_port_range = (2200..20000)

  r = rand(36**10).to_s(36)

  (1..3).each do |i|
    config.vm.define "slave#{i}" do |slave|
	slave.vm.hostname = "Slave#{i}-#{r}"

    slave.vm.provider "virtualbox" do |vb|
       vb.memory = 180
       vb.linked_clone = true
    end
    end
  end
end
