class graphite::relay::install {

    include 'graphite::common::install'

    package { [ 'python-whisper',
                'python-carbon']:
        ensure  => latest,
        require => Exec['apt-get update'],
    }
}