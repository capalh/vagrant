# Write in Ruby. 

# Define a host_list including the attribute of hostname and image version 

host_list = [
    {
        :name => "host-1",
        :box => "centos/7"
    },

]

Vagrant.configure("2") do |config|  
    host_list.each do |item|                                        # use .each method to loop up all item in host_list
        config.vm.define item[:name] do |host|                      # define the host name and read the attribute from host_list
            host.vm.hostname = item[:name]                          # set the hostname
            host.vm.box = item[:box]                                # set the box version 
            host.vm.network "forwarded_port", guest:80, host:8000   # set port forwarding policy. Note: Only applied for virtualbox
            host.ssh.insert_key = false                             # disable replace generated key pair, use insecure key
        end
    end
end