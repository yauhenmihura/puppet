servers=[
  {
    :hostname => "master.mihura.com",
    :ip => "192.168.33.14",
    :box => "centos/7",
    :ram => 4096,
    :cpu => 1
  },
  {
    :hostname => "node1.mihura.com",
    :ip => "192.168.33.13",
    :box => "centos/7",
    :ram => 512,
    :cpu => 1
  }
]

Vagrant.configure(2) do |config|
    servers.each do |machine|
        config.vm.define machine[:hostname] do |node|
            node.vm.box = machine[:box]
            node.vm.hostname = machine[:hostname]
            node.vm.network "private_network", ip: machine[:ip]
            node.vm.provider "virtualbox" do |vb|
              vb.customize ["modifyvm", :id, "--memory", machine[:ram]]
	    end
        config.vm.provision "puppet" do |puppet|
          puppet.manifests_path = ["vm", "/vagrant/manifests"]
          puppet.manifest_file = "init.pp"
        end
	end
    end
end	

