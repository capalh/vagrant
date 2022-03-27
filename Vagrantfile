# Write in Ruby. 

# Define a host_list that defines each hosts parameters. 

host_list = [
    {
        :name => "host-1",
        :box => "centos/7"
    },
    {
        :name => "host-2",
        :box => "generic/centos8"
    },
]


Vagrant.configure("2") do |config|  
    host_list.each do |item|                        # use .each method to loop up all item in host_list
        config.vm.define item[:name] do |host|      # define the host name and read the attribute from host_list
            host.vm.box = item[:box]                # set the box version 
        end
    end
end