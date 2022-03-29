# Write in Ruby. 

# Define a host_list including the attribute of hostname and image version 

host_list = [

    {
        :name => "host-1",
        :eth1 => "192.168.200.11"
    },

    {
        :name => "host-2",
        :eth1 => "192.168.200.12"
    },

]

Vagrant.configure("2") do |config|  
    config.vm.box = "centos/7"
    host_list.each do |item|                                        # use .each method to loop up all item in host_list
        config.vm.define item[:name] do |host|                      # define the host name and read the attribute from host_list
            host.vm.hostname = item[:name]                          # set the hostname
            host.vm.network "private_network", type: "dhcp"         # set priviate network type as DHCP
            host.vm.network "public_network"
        end
    end
end