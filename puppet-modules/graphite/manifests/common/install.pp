class graphite::common::install {

    file {'graphite.sources.list':
        ensure  => present,
        path    => '/etc/apt/sources.list.d/graphite.sources.list',
        source  => 'puppet:///modules/graphite/graphite.sources.list',
        owner   => 'root',
        group   => 'root',
    }

    file { '/tmp/pgp-keys':
        ensure  => directory,
        recurse => true,
        source  => 'puppet:///modules/graphite/gpg',
    }

    exec { 'apt-key add':
        command     => '/usr/bin/apt-key add /tmp/pgp-keys/*',
        subscribe   => File['/tmp/pgp-keys'],
        refreshonly => true,
    }

    exec {'apt-get update':
        command => '/usr/bin/apt-get update',
        require => [File['graphite.sources.list'],
                    Exec['apt-key add']],
    }

    package { [ 'vim',
                'puppet']:
        ensure  => latest,
        require => Exec['apt-get update'],
    }

}