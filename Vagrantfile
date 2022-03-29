
host_list = [

    {
        :name => "host-1",
        :eth1 => "192.168.200.11"
    },

]

Vagrant.configure("2") do |config|  
    config.vm.box = "centos/7"
    host_list.each do |item|                                       
        config.vm.define item[:name] do |host|                      
            host.vm.hostname = item[:name]                         
            host.vm.network "private_network", ip: item[:eth1]      
        end
    end
    config.vm.provision "shell", inline: <<-SHELL
        sudo yum install -y epel-release
        sudo yum install -y nginx
        sudo systemctl start nginx
    SHELL
end