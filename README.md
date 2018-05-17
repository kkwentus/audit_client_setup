# audit_client_setup

This is an example wrapper cookbook for how to set attributes necessary for Chef audit and chef-client wrapper cookbooks.  These dependencies are defined in the metadata.rb and then the default recipes for both cookbooks are called after attributes are defined.

* It is recommended to run a "berks update" and then "berks upload --ssl-verify false" as best-practice to upload a wrapper cookbook such as this which may have many layers of dependencies


## audit

The audit cookbook is the mechanism for how chef-client can automatically executes compliance (i.e. InSpec) profiles against nodes, allowing for continous compliance (vs a one-time remote scan).   Once the audit cookbook is in your runlist for a node, it will always be executed at the end of a chef-client run so that the data in Chef Automate reflects the state of the latest compliance vs the very latest desired state that chef-client has enforced.

In order for this cookbook to properly run a compliance profile in your environment, make sure and update the name of the compliance profile to include your Automate username with admin permissions.

   * For example, my Automate user is chefadmin and the profile I want is linux-baseline, thus "compliance: chefadmin/linux-baseline" that is coded in this cookbook.   
   
In this example only one profile is being set depending on the type of OS, but multiple profiles can be defined and run against a node.

Also note: I have also already downloaded the windows-baseline and linux-baseline profiles from within the Profile Store in Automate UI, as the chefadmin user.  This is required for OOTB profiles to become available to use.



#### Documentation on audit cookbook functionality, and all available attributes
https://supermarket.chef.io/cookbooks/audit

## chef-client
The chef-client cookbook is required to be part of a node's runlist in order to trigger the automated "test and repair" functionality that continually enforces desired state and is most often expected/desired from Chef users.  If you don't put this cookbook in your runlist, chef-client will never execute again automatically after inital bootstrap.    Setting of the interval or frequency attributes is optional.  If they are not defined there are default values that will be used.   For those who want continuous enforcement of state, a best-practice is to have a wrapper cookbook, such as this, that will call chef-client, as a part of your initial bootstrap runlist.

ex:
  * knife bootstrap NODEIP --sudo -x USER -i KEY --node-ssl-verify-mode none -N CHEFNODELABEL -r 'recipe[audit_client_setup]'

The attributes as defined in this cookbook set the chef-client to checkin every 15 minutes both either Windows of Linux.  In the case of the chef-client cookbook, the attributes are different per platform. 


#### Documentation on chef-client cookbook functionality, and all available attributes
https://supermarket.chef.io/cookbooks/chef-client


