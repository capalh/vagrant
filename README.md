## What's vagrant?

1. A tool for builing and managing virtual machine environments. 
2. Free and open source write in Ruby 
3. Providers: `VirtialBox`, `VMware`, `Hpyer-v`
4. Provisioners: `shell`, `Ansible`, `Puppet`
5. Vagrant VS. Docker -> VM vs Container
6. Vagrant VS. Terraform:
    
    `Vagrant` is a tool fucused for managing development env.

    `Terraform` is a tool for building infrastructure by levarage public cloud like AWS, Azure, etc. Infrastructure as a code. Seamless tranfer between cloud providers. 

7. Inside the .vagrant folder


?  docker-learning git:(main) tree .vagrant
.vagrant
©À©¤©¤ bundler
©¦?? ©¸©¤©¤ global.sol
©À©¤©¤ machines
©¦?? ©¸©¤©¤ docker-host
©¦??     ©¸©¤©¤ virtualbox
©¦??         ©À©¤©¤ action_provision
©¦??         ©À©¤©¤ action_set_name
©¦??         ©À©¤©¤ box_meta
©¦??         ©À©¤©¤ creator_uid
©¦??         ©À©¤©¤ id
©¦??         ©À©¤©¤ index_uuid
©¦??         ©À©¤©¤ private_key
©¦??         ©À©¤©¤ synced_folders
©¦??         ©¸©¤©¤ vagrant_cwd
©¸©¤©¤ rgloader
    ©¸©¤©¤ loader.rb


## Installation on macOS

1. Install VirtualBox - https://www.virtualbox.org/wiki/Downloads
2. Install Vagrant for mac - https://www.vagrantup.com/downloads


## Vagrantfile

1. Write in Ruby. 
2. A sample Vagrantfile

```
Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
end
```


## Vagrant CLI

1. Check the downloaded images `vagrant box list`
2. Add a box repo source `vagrant box add centos7 https://xxx`
3. 