
# stuff
define graphite::relay::relay_service($vip) {

    $instance = $name

    file { "/etc/init/carbon-relay-${vip}-${instance}.conf":
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        content => template('graphite/relay/carbon-relay.upstart.erb'),
    }

    service { "carbon-relay-${vip}-${instance}":
        ensure    => running,
        provider  => upstart,
        require   => File["/etc/init/carbon-relay-${vip}-${instance}.conf"],
        subscribe => File["${vip}-relay-conf_file", "${vip}-relay-rules.conf"],
    }
}