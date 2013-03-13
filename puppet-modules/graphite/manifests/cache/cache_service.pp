
# stuff
define graphite::cache::cache_service($vip) {

    $instance = $name

    file { "/etc/init/carbon-cache-${vip}-${instance}.conf":
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        content => template('graphite/cache/carbon-cache.upstart.erb'),
    }

    service { "carbon-cache-${vip}-${instance}":
        ensure    => running,
        provider  => upstart,
        require   => File["/etc/init/carbon-cache-${vip}-${instance}.conf"],
        subscribe => File["${vip}-cache-conf_file", "${vip}-storage-schemas.conf"],
    }
}