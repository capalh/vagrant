# Write in Ruby. 

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