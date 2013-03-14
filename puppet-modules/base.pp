class base {

    graphite::relay::instance{ 'default':
        conf_file               => '/home/vagrant/relay.conf',
        line_receiver_port      => ['2013'],
        relay_method            => ['consistent-hashing'],
        destinations            => [['127.0.0.1:2004:default'],['127.0.0.1:2006:b'],['127.0.0.1:2008:c']],
    }

    graphite::cache::instance{ 'default':
        conf_file               => '/home/vagrant/carbon.conf',
        instance_name           => ['default','b'   ,'c'],
        line_receiver_port      => ['2003'   ,'2005','2007'],
        pickle_receiver_port    => ['2004'   ,'2006','2008'],
        cache_query_port        => ['7002'   ,'7102','7202'],
    }

    class {'graphite::web::apache_install': }
}
include base
