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

3. Add a hostname and specific CentOS version

```
Vagrant.configure("2") do |config|  
    config.vm.box = "centos/7"
    config.vm.hostname = "vagrant-demo"   # Add a hostname
    config.vm.box_version = "1905.1"      # Use specific version
  end
```



## Vagrant CLI

1. Check the downloaded images `vagrant box list`
2. Add a box repo source `vagrant box add centos7 https://xxx`
3. 