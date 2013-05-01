vagrant-puppet-graphite
=======================

Vagrant setup with a puppet module for Graphite (Metrics)

Currently module only tested to work on Ubuntu 12.04

I require the ability to create multiple instances of carbon for different teams, potentially listening on different virtual network interfaces which can then be moved onto other servers without issue.

HOWTO:
``` bash
 # Install Vagrant and Virtualbox (http://docs-v1.vagrantup.com/v1/docs/getting-started/)
 $ git clone https://github.com/stuart-warren/vagrant-puppet-graphite.git
 $ cd vagrant-puppet-graphite
 $ vagrant up
 # wait....
 $ echo "local.random.diceroll 4 `date +%s`" | nc 192.168.10.21 2013;
 # go to http://192.168.10.21/dashboard/
```

Carbon daemons can be started/stopped with
``` bash
 $ sudo start carbon-cache-default-[instancename]
```
By default: (see Vagrantfile and puppet-modules/base.pp)
- Timezone is Europe/London
- IP is 192.168.10.21
- Starts 1 carbon relay, spreading metrics over 3 carbon caches
- You can send metrics to the relay on port 2013

TODO:

- [x] Make carbon-relay do the same as carbon-cache #1
- [x] Finish the graphite-web classes so they can be customised #2
- [x] Remove unneeded start scripts #3
- [ ] Investigate upstart not using --debug to start carbon-cache without loosing pid
- [x] Upload debs somewhere

Please note, I am now mostly using OpenTSDB/KairosDB.
