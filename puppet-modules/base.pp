class base {

    graphite::relay::instance{ 'default':
        conf_file               => '/home/vagrant/relay.conf',
        line_receiver_port      => ['2013'],
        destinations            => [['127.0.0.1:2004'],['127.0.0.1:2006'],['127.0.0.1:2008']],
    }

    graphite::cache::instance{ 'default':
        conf_file               => '/home/vagrant/carbon.conf',
        instance_name           => ['default','b'   ,'c'],
        line_receiver_port      => ['2003'   ,'2005','2007'],
        pickle_receiver_port    => ['2004'   ,'2006','2008'],
        cache_query_port        => ['7002'   ,'7003','7004'],
    }

    class {'graphite::web::apache_install': }
}
include base