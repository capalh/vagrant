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
2. A simple Vagrantfile - automatically generated after running `vagrant init centos/7`

```
Vagrant.configure("2") do |config|  
  config.vm.box = "centos/7"
end
```

Note: if want to write a simple vagrantfile quickly, refer the sample code - `A simple vagrantfile`

3. Add loop function of ruby in a vagrantfile - `multiple-hosts`

## 3 - Folder synchronization between vagrant VMs and hosts

We can sync up the folder between the vagrant VMs and its host. We could the following logs from the logs entry after create a VM

```
host-1: Rsyncing folder: ~/DevOps/vagrant/test/ => /vagrant
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

1. Forwarded network port policy, sample code - `network-forwarded-port-policy`

2. Private Network, sample code - `network-private-network`

3. Public Network , sample code - `network-public-network`

## 5 - Vagrant Provisioning

1. We can install some tools and yum packages after the VMs deployed
2. There are multiple automation technology to leverage by vagrant, like `shell`, `Ansible`, `docker`, etc

#### 5.1 Shell provisioner

1. Inline shell. Sample code at `provision-shell-inline`
2. shell script. Sample the code `provison-shell-script`


#### 5.2 Ansible provisioner

1. We can also use Ansible as the provisioner
2. See the sample code from the `provision-ansible` folder.



## Vagrant frequently used CLI

1. Check the downloaded images `vagrant box list`
2. Add a box repo source `vagrant box add centos7 https://xxx`
3. Add/remove an image `vagrant box add/remove generic/ubuntu2004`
4. Install vbguest `vagrant plugin install vagrant-vbguest`
5. Package a customized box `vagrant package --base VM_ID`
6. Add to vagrant box list `vagrant box add --name NAME ./package_name`
7. Init a customized package `vagrant init centos-vim`
