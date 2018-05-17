#
# Cookbook:: audit_client_setup
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

node.default['audit']['inspec_version'] = 'latest'

#Defines the collector or collectors. Can take single item or items[]
#This specific config will push data directly to an existing Compliance server
node.default['audit']['reporter'] = 'chef-server-automate' 


case node['platform']
when 'debian', 'ubuntu', 'redhat','centos','fedora'
  node.default['audit']['profiles'] = [
      {
        "name": "linux-baseline",
        "compliance": "chefadmin/linux-baseline"
      }
  ]
  ## linux attribute to set chef-client runs second on the node.
  node.default['chef_client']['interval'] = '900'
when 'windows'
  node.default['audit']['profiles'] = [
    {
      "name": "windows-baseline",
      "compliance": "chefadmin/windows-baseline"
    }
  ]
    ##windows attributes to set running chef-client as a task on the node
    node.default['chef_client']['task']['frequency'] = 'minute'
    ## minutes between chef-client run.  
    node.default['chef_client']['task']['frequency_modifier'] = '30'
end


include_recipe 'audit::default'
include_recipe 'chef-client::default'