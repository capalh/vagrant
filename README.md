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


## Installation on macOS

1. Install VirtualBox - https://www.virtualbox.org/wiki/Downloads
2. Install Vagrant for mac - https://www.vagrantup.com/downloads


## Vagrantfile

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



## Sync up the folder betwwen vagrant host and the bare metal machine

We can sync up the folder between the vagrant host and the macOS system. See the following logs ->

```
host-1: Rsyncing folder: /Users/jasonli/DevOps/vagrant/test/ => /vagrant
```

To achive this, we will need to:

1. Modify the file from PATH `~/.vagrant.d/boxes/centos-VAGRANTSLASH-7/1905.1/virtualbox`
2. Disable `config.vm.synced_folder ".", "/vagrant", type: "rsync"`
3. Install the vbguest plugin, like the following

```
vagrant plugin list

vagrant-vbguest (0.21.0, global)
  - Version Constraint: 0.21
```

Then the folder will be sync up between `/Users/jasonli/DevOps/vagrant/test/` and `/vagrant` under the virtual machine. 

## Vagrant CLI

1. Check the downloaded images `vagrant box list`
2. Add a box repo source `vagrant box add centos7 https://xxx`
