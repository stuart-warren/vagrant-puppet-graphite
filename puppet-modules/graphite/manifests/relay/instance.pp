define graphite::relay::instance (
        $conf_file                  = ['/var/lib/graphite/conf/relay.conf'],
        $storage_dir                = ['/var/lib/graphite/storage/'],
        $local_data_dir             = ['/var/lib/graphite/storage/whisper/'],
        $whitelists_dir             = ['/var/lib/graphite/storage/lists/'],
        $conf_dir                   = ['/var/lib/graphite/conf/'],
        $log_dir                    = ['/var/lib/graphite/storage/log/carbon/'],
        $pid_dir                    = ['/var/run'],
        $user                       = ['www-data'],
        $group                      = ['www-data'],
        $instance_name              = ['default'],
        $line_receiver_interface    = ['0.0.0.0'],
        $line_receiver_port         = ['2013'],
        $pickle_receiver_interface  = ['0.0.0.0'],
        $pickle_receiver_port       = ['2014'],
        $relay_method               = ['rules'],
        $replication_factor         = ['1'],
        $destinations               = [['127.0.0.1:2004']],
        $max_datapoints_per_message = ['500'],
        $max_queue_size             = ['10000'],
        $use_flow_control           = ['True'],
        $use_whitelist              = ['False'],
        $carbon_metric_prefix       = ['carbon'],
        $carbon_metric_interval     = ['60'],
    ) {

    include graphite::cache::install

    $vip = $title

    file { "${vip}-relay-conf_file":
        ensure    => present,
        path      => $conf_file,
        owner     => 'root',
        group     => 'root',
        content   => template('graphite/relay/carbon-relay.conf.erb'), #template
        require   => Package['python-carbon'],
    }

    file { "${vip}-relay-rules.conf":
        ensure    => present,
        path      => "${conf_dir}relay-rules.conf",
        owner     => root,
        group     => root,
        content   => template('graphite/relay/relay-rules.conf.erb'),
        require   => Package['python-carbon'],
    }

    graphite::relay::relay_service{ $instance_name:
        vip       => $vip,
        require   => File["${vip}-local-data-dir"],
    }
}