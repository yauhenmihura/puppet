servers=[
  {
    :hostname => "master.mihura.com",
    :ip => "192.168.33.14",
    :box => "sbeliakou/centos-6.7-x86_64",
    :ram => 4096,
    :cpu => 1
  },
  {
    :hostname => "node1.mihura.com",
    :ip => "192.168.33.13",
    :box => "sbeliakou/centos-6.7-x86_64",
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
            node.vm.provision "shell", inline: <<-SHELL
            rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm
            yum install puppet -y
            SHELL
              node.vm.provider "virtualbox" do |vb|
                vb.customize ["modifyvm", :id, "--memory", machine[:ram]]
		end
	end
    end
end	

