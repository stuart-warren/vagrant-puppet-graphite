class graphite::web::install {

    include 'graphite::common::install'

    package { [ 'python-graphite-web',
                'libapache2-mod-wsgi']:
        ensure  => latest,
        require => Exec['apt-get update'],
    }
}