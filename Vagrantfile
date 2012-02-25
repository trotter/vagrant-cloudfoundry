# -*- mode: ruby -*-
# vi: set ft=ruby :
require File.expand_path("../vcap/dev_setup/lib/job_manager", __FILE__)

Vagrant::Config.run do |config|
  config.vm.box = "ubuntu-10.04.2-cloud-foundry.box"

  config.vm.customize [
    "modifyvm", :id,
    "--memory", "1024"
  ]

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://files.vagrantup.com/lucid64.box"

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  # config.vm.network :hostonly, "33.33.33.10"

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port 80, 3500

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  # Enable provisioning with chef solo, specifying a cookbooks path (relative
  # to this Vagrantfile), and adding some recipes and/or roles.
  #
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "vcap/dev_setup/cookbooks"
    chef.roles_path     = "vcap/dev_setup/roles"

    spec = {
      :deployment => {
        :name  => "vagrant",
        :user  => "vagrant",
        :group => "admin",
        :domain => "vcap.me"
      },
      :cloudfoundry => {
        :home => "/home/vagrant/cloudfoundry"
      },
      :jobs => {
        :install => [ "all" ]
      }
    }

    ["vcap_pre_install", "nats_server", "ccdb", "cloudfoundry", "router", "cloud_controller", "health_manager", "dea", "redis_node", "mysql_node", "mongodb_node", "neo4j_node", "redis_gateway", "mysql_gateway", "mongodb_gateway", "neo4j_gateway"].each do |role|
      chef.add_role role
    end
    specs, roles, run_list = JobManager.go(spec)
    require 'ruby-debug'; debugger; 1

    (JobManager::JOBS - ["all"]).each do |role|
      chef.add_role role
    end

    # You may also specify custom JSON attributes:
    chef.json = {
      :deployment => {
        :user  => "vagrant",
        :group => "admin"
      },
      :cloudfoundry => {
        :home => "/home/vagrant/cloudfoundry"
      }
    }

  end
end
