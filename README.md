vagrant-puppet-graphite
=======================

Vagrant setup with a puppet module for Graphite (Metrics)

Currently module only tested to work on Ubuntu 12.04

I require the ability to create multiple instances of carbon for different teams, potentially listening on different virtual network interfaces which can then be moved onto other servers without issue.

Carbon daemons can be started with 
 sudo start carbon-cache-default-<instancename>

Currently you will need to supply your own .debs which mostly install to /var/lib/graphite/ rather than /opt/graphite/

TODO:

- [x] Make carbon-relay do the same as carbon-cache #1
- [x] Finish the graphite-web classes so they can be customised #2
- [x] Remove unneeded start scripts #3
- [ ] Investigate upstart not using --debug to start carbon-cache without loosing pid
- [ ] Upload debs somewhere

- [x] @mentions, #refs, [links](), **formatting**, and <del>tags</del> supported
- [x] list syntax required (any unordered or ordered list supported)
- [x] this is a complete item
- [ ] this is an incomplete item