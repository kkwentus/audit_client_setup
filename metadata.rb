name 'audit_client_setup'
maintainer 'Karen Kwentus'
maintainer_email 'kkwentus@chef.io'
license 'All Rights Reserved'
description 'Installs/Configures core_setup'
long_description 'Installs/Configures core_setup'
chef_version '>= 12.1' if respond_to?(:chef_version)

version '1.0.0'

depends 'audit'
depends 'chef-client'
