# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant::Config.run do |config|
  config.vm.box = "ubuntu-10.04.2-cloud-foundry.box"

  config.vm.customize [
    "modifyvm", :id,
    "--memory", "1024",
    "--chipset", "ich9",
    "--cpus", "2",
    "--vram", "10"
  ]

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = File.dirname(__FILE__) + "/veewee/ubuntu-10.04.2-cloud-foundry.box"

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  # config.vm.network :hostonly, "33.33.33.10"

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port 80, 8080

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  # Enable provisioning with chef solo, specifying a cookbooks path (relative
  # to this Vagrantfile), and adding some recipes and/or roles.
  #
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
#    chef.roles_path     = "roles"

    chef.add_recipe "nats-server"
    chef.add_recipe "cloudfoundry-ruby-runtime"
    chef.add_recipe "cloudfoundry-java-runtime"
    chef.add_recipe "cloudfoundry-cloud_controller"
    chef.add_recipe "cloudfoundry-router"
    chef.add_recipe "cloudfoundry-health_manager"
    chef.add_recipe "cloudfoundry-dea"
    chef.add_recipe "cloudfoundry-mysql-service"

    chef.json = {
      :postgresql => { :password => { :postgres => "password" } } # Root postgres password
    }
  end
end
