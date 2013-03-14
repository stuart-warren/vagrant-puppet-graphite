# stuff
define graphite::cache::instance (
        $conf_file                  = ['/var/lib/graphite/conf/carbon.conf'],
        $instance_name              = ['default'],
        $storage_dir                = ['/var/lib/graphite/storage/'],
        $local_data_dir             = ['/var/lib/graphite/storage/whisper/'],
        $whitelists_dir             = ['/var/lib/graphite/storage/lists/'],
        $conf_dir                   = ['/var/lib/graphite/conf/'],
        $log_dir                    = ['/var/lib/graphite/storage/log/carbon/'],
        $pid_dir                    = ['/var/run'],
        $user                       = ['www-data'],
        $group                      = ['www-data'],
        $max_cache_size             = ['inf'],
        $max_updates_per_second     = ['500'],
        $max_creates_per_minute     = ['50'],
        $line_receiver_interface    = ['0.0.0.0'],
        $line_receiver_port         = ['2003'],
        $enable_udp_listener        = ['False'],
        $udp_receiver_interface     = ['0.0.0.0'],
        $udp_receiver_port          = ['2003'],
        $pickle_receiver_interface  = ['0.0.0.0'],
        $pickle_receiver_port       = ['2004'],
        $use_insecure_unpickler     = ['False'],
        $cache_query_interface      = ['0.0.0.0'],
        $cache_query_port           = ['7002'],
        $use_flow_control           = ['True'],
        $log_updates                = ['False'],
        $whisper_autoflush          = ['False'],
        $whisper_sparse_create      = ['False'],
        $whisper_lock_writes        = ['False'],
        $use_whitelist              = ['False'],
        $carbon_metric_prefix       = ['carbon'],
        $carbon_metric_interval     = ['60'],
        $enable_amqp                = ['False'],
        $amqp_verbose               = ['False'],
        $amqp_host                  = ['localhost'],
        $amqp_port                  = ['5672'],
        $amqp_vhost                 = ['/'],
        $amqp_user                  = ['guest'],
        $amqp_password              = ['guest'],
        $amqp_exchange              = ['graphite'],
        $amqp_metric_name_in_body   = ['False'],
        $enable_manhole             = ['False'],
        $manhole_interface          = ['127.0.0.1'],
        $manhole_port               = ['7222'],
        $manhole_user               = ['admin'],
        $manhole_public_key         = ['ssh-rsa AAAAB3NzaC1yc2EAAAABiwAaAIEAoxN0sv/e4eZCPpi3N3KYvyzRaBaMeS2RsOQ/cDuKv11dlNzVeiyc3RFmCv5Rjwn/lQ79y0zyHxw67qLyhQ/kDzINc4cY41ivuQXm2tPmgvexdrBv5nsfEpjs3gLZfJnyvlcVyWK/lId8WUvEWSWHTzsbtmXAF2raJMdgLTbQ8wE='],
        $bind_patterns              = ['#'],

        $storage_schema_pattern     = ['.*'],
        $storage_schema_retentions  = [ '60s:1d' ],
    ) {

    include graphite::cache::install

    $vip = $title

    file { "${vip}-cache-conf_file":
        ensure    => present,
        path      => $conf_file,
        owner     => 'root',
        group     => 'root',
        content   => template('graphite/cache/carbon-cache.conf.erb'), #template
        require   => Package['python-carbon'],
    }

    file { "${vip}-storage-schemas.conf":
        ensure    => present,
        path      => "${conf_dir}storage-schemas.conf",
        owner     => root,
        group     => root,
        content   => template('graphite/cache/storage-schemas.conf.erb'),
        require   => Package['python-carbon'],
    }

    file { "${vip}-local-data-dir":
        ensure    => directory,
        path      => $local_data_dir,
        owner     => $user,
        group     => $group,
        require   => Package['python-carbon'],
    }

    graphite::cache::cache_service{ $instance_name:
        vip       => $vip,
        require   => File["${vip}-local-data-dir"],
    }

}
