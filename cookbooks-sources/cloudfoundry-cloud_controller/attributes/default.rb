include_attribute "cloudfoundry-common"

default['cloudfoundry_cloud_controller']['server']['domain'] = 'vcap.me'
default['cloudfoundry_cloud_controller']['server']['welcome'] = "VMWare's Cloud Application Platform"
default['cloudfoundry_cloud_controller']['server']['support_address'] = 'http://support.cloudfoundry.com'

default['cloudfoundry_cloud_controller']['server']['allow_registration'] = true
default['cloudfoundry_cloud_controller']['server']['allow_external_app_uris'] = false

default['cloudfoundry_cloud_controller']['server']['external_port'] = 9022
default['cloudfoundry_cloud_controller']['server']['use_nginx'] = false
default['cloudfoundry_cloud_controller']['server']['insecure_instance_port'] = 9025

default['cloudfoundry_cloud_controller']['server']['log_level'] = 'debug'
default['cloudfoundry_cloud_controller']['server']['log_file'] = "#{node[:cloudfoundry_common][:log_dir]}/cloud_controller.log"
default['cloudfoundry_cloud_controller']['server']['rails_log_file'] = "#{node[:cloudfoundry_common][:log_dir]}/cloud_controller-rails.log"

default['cloudfoundry_cloud_controller']['server']['allow_debug'] = "#{node[:cloudfoundry_common][:log_dir]}/cloud_controller-rails.log"

default['cloudfoundry_cloud_controller']['server']['max_current_stagers'] = 10
default['cloudfoundry_cloud_controller']['server']['max_staging_runtime'] = 120
default['cloudfoundry_cloud_controller']['server']['staging_secure'] = false

default['cloudfoundry_cloud_controller']['server']['admins'] = ['you@example.com']

default['cloudfoundry_cloud_controller']['database']['name'] = 'cloud_controller'
default['cloudfoundry_cloud_controller']['database']['host'] = 'localhost'

# XXX: Not sure we can store hashes in an attribute. Will have to test
#      this part thoroughly.
default['cloudfoundry_cloud_controller']['server']['runtimes'] = [
  { :name => "ruby19", :version => node[:cloudfoundry_common][:ruby_1_9_2_version] }
]

default['cloudfoundry_cloud_controller']['server']['frameworks'] = [
  'platform',
  'rails3'
]

default[:cloudfoundry_cloud_controller]['server']['pid_file'] = File.join(node[:cloudfoundry_common][:pid_dir], "cloud_controller.pid")

