# Install apache version of graphite
class graphite::web::apache_install(


    ){

    include 'graphite::common::install'

    package { [ 'python-graphite-web',
                'libapache2-mod-wsgi',
                'memcached']:
        ensure  => latest,
        require => Exec['apt-get update'],
    }

    service { 'apache2':
        ensure  => running,
        enable  => true,
        require => Package['libapache2-mod-wsgi'],
    }

    file { '/etc/apache2/sites-available/default':
        ensure  => present,
        content => template('graphite/web/graphite.apache2.erb'),
        owner   => 'root',
        group   => 'root',
        require => Package['libapache2-mod-wsgi'],
        notify  => Service['apache2'],
    }

    file { '/etc/apache2/run':
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        require => Package['libapache2-mod-wsgi'],
    }

    file { '/var/lib/graphite/conf/graphite.wsgi':
        ensure  => present,
        content => template('graphite/web/graphite.wsgi.erb'),
        owner   => 'root',
        group   => 'root',
        require => [File['/etc/apache2/run'],
                    Package['python-graphite-web']],
        notify  => Service['apache2'],
    }

    file { '/usr/share/pyshared/graphite/local_settings.py':
        ensure  => present,
        content => template('graphite/web/local_settings.py.erb'),
        owner   => 'root',
        group   => 'root',
        require => Package['python-graphite-web'],
    }

    file { '/var/lib/graphite/storage/index':
        ensure  => present,
        owner   => 'www-data',
        group   => 'www-data',
        require => Package['python-graphite-web'],
    }

    file { '/var/lib/graphite/storage/':
        ensure  => directory,
        owner   => 'www-data',
        group   => 'www-data',
        require => Package['python-graphite-web'],
    }

    file { '/var/lib/graphite/storage/log/webapp/':
        ensure  => directory,
        owner   => 'www-data',
        group   => 'www-data',
        require => Package['python-graphite-web'],
    }

    exec { 'syncdb':
        command => '/usr/bin/python /usr/lib/python2.7/dist-packages/graphite/manage.py syncdb --noinput',
        cwd     => '/usr/lib/python2.7/dist-packages/graphite',
        require => Package['python-graphite-web'],
    }

    file { '/var/lib/graphite/storage/graphite.db':
        ensure  => present,
        owner   => 'www-data',
        group   => 'www-data',
        mode    => '0664',
        require => Exec['syncdb'],
    }


}