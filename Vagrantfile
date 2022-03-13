# Vagrantfile for CentOS/7

boxes = [
    {
        :name => "host-1",
        :eth1 => "192.168.99.11",
        :mem => "2048",
        :cpu => "2"
    },
    {
      :name => "host-2",
      :eth1 => "192.168.99.12",
      :mem => "1024",
      :cpu => "1"
    },
    {
      :name => "host-3",
      :eth1 => "192.168.99.13",
      :mem => "1024",
      :cpu => "1"
    }
]

Vagrant.configure(2) do |config|

  config.vm.box = "centos/7"
  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
      config.vm.hostname = opts[:name]
      config.vm.provider "vmware_fusion" do |v|
        v.vmx["memsize"] = opts[:mem]
        v.vmx["numvcpus"] = opts[:cpu]
      end
      config.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--memory", opts[:mem]]
        v.customize ["modifyvm", :id, "--cpus", opts[:cpu]]
      end
      config.vm.network :private_network, ip: opts[:eth1]
    end
  end
end