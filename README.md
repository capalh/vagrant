## What's vagrant?

1. A tool for builing and managing virtual machine environments. 
2. Free and open source write in Ruby 
3. Providers: `VirtialBox`, `VMware`, `Hpyer-v`
4. Provisioners: `shell`, `Ansible`, `Puppet`
5. Vagrant VS. Docker -> VM vs Container
6. Vagrant VS. Terraform:
    
    `Vagrant` is a tool fucused for managing development env.

    `Terraform` is a tool for building infrastructure by levarage public cloud like AWS, Azure, etc. Infrastructure as a code. Seamless tranfer between cloud providers. 

7. Inside the .vagrant folder, including the metadata of Vagrant; and the ~/.vagrant.d/ folder containes the images. 


## 1 - Installation on macOS

1. Install VirtualBox - https://www.virtualbox.org/wiki/Downloads
2. Install Vagrant for mac - https://www.vagrantup.com/downloads


## 2 - Vagrantfile

1. Write in Ruby. 
2. A sample Vagrantfile - the same as when using `vagrant init centos/7`

```
Vagrant.configure("2") do |config|  
  config.vm.box = "centos/7"
end
```

3. Configure hostname and specific CentOS version

```
Vagrant.configure("2") do |config|  
    config.vm.box = "centos/7"
    config.vm.hostname = "vagrant-demo"   # Add a hostname
    config.vm.box_version = "1905.1"      # Use specific version
  end
```

4. Configure multiple vagrant host

```
Vagrant.configure("2") do |config|  
    config.vm.box = "centos/7"
    config.vm.hostname = "vagrant-demo"         # Add a hostname, this is global variable
    config.vm.box_version = "1905.1"            # Use specific version, this is global variable 
    config.vm.define "host-1-web" do |web|      # Create a web ojbect 
        web.vm.hostname = "web"                 # setup the hostname as web for host-1
        web.vm.box_version = "2004.01"          # setup the box version using local variable
    end
    config.vm.define "host-2-db" do |db|
        db.vm.hostname = "db"                   # setup the hostname for host-2 as db
    end
end
```

5. Optimize the code - use each method to lookup defined hosts in host_list[]

```
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
```



## 3 - Sync up the folder between vagrant host and macOS

We can sync up the folder between the vagrant host and the macOS system. See the following logs ->

```
host-1: Rsyncing folder: /Users/jasonli/DevOps/vagrant/test/ => /vagrant
```

To achive this, we will need to:

1. Modify the file from PATH `~/.vagrant.d/boxes/centos-VAGRANTSLASH-7/1905.1/virtualbox`
2. Disable `config.vm.synced_folder ".", "/vagrant", type: "rsync"`
3. Install the vbguest plug-in, like the following

```
vagrant plugin list

vagrant-vbguest (0.21.0, global)
  - Version Constraint: 0.21
```

Then the folder will be sync up between `~/DevOps/vagrant/test/` and `/vagrant` under the virtual machine. 


## 4 - Vagrant Network

1. Forwarded network port policy, sample vagrantfile

```
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
```

2. Private Network: For virtualbox, the created VM under en0 with assigned IP 10.0.2.15, the hosts can't reach out to each others. So need to rely on the private network. Sample code:

```
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
    config.vm.box = "centos/7"                                      # set the global box image version
    host_list.each do |item|                                        # Loop up all items defined at host_list[]
        config.vm.define item[:name] do |host|                      # define the host name, read the attribute from host_list
            host.vm.hostname = item[:name]                          # set the hostname
            host.vm.network "private_network", ip: item[:eth1]      # set priviate network that allow hosts can reach out to each other, read the option from host_list
        end
    end
end

```

Or we can use the type as DHCP

```
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
    config.vm.box = "centos/7"                                      # set the global box image version
    host_list.each do |item|                                        # Loop up all items defined at host_list[]
        config.vm.define item[:name] do |host|                      # define the host name, read the attribute from host_list
            host.vm.hostname = item[:name]                          # set the hostname
            host.vm.network "private_network", type:"dhcp"          # set priviate network type as DHCP
        end
    end
end

```

3. Public Network 

```
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
            host.vm.network "public_network"                        # set public IP address
        end
    end
end
```



## Vagrant CLI

1. Check the downloaded images `vagrant box list`
2. Add a box repo source `vagrant box add centos7 https://xxx`
3. Add/remove an image `vagrant box add/remove generic/ubuntu2004`
4. Install vbguest `vagrant plugin install vagrant-vbguest`
5. Package a customized box `vagrant package --base VM_ID`
6. Add to vagrant box list `vagrant box add --name NAME ./package_name`
7. Init a customized package `vagrant init centos-vim`
