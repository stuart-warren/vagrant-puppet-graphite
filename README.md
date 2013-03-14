vagrant-puppet-graphite
=======================

Vagrant setup with a puppet module for Graphite (Metrics)

Currently module only tested to work on Ubuntu 12.04

I require the ability to create multiple instances of carbon for different teams, potentially listening on different virtual network interfaces which can then be moved onto other servers without issue.

Carbon daemons can be started with 
 sudo start carbon-cache-default-<instancename>

Currently you will need to supply your own .debs which mostly install to /var/lib/graphite/ rather than /opt/graphite/

TODO:
 - [x] 1. Make carbon-relay do the same as carbon-cache #1
 - [x] 2. Finish the graphite-web classes so they can be customised #2
 - [x] 3. Remove unneeded start scripts #3
 - [ ] 4. Investigate upstart not using --debug to start carbon-cache without loosing pid
 - [ ] 5. Upload debs somewhere