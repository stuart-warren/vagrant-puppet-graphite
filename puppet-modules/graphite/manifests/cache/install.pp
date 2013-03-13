#
class graphite::cache::install {

    include 'graphite::common::install'

    package { [ 'python-whisper',
                'python-carbon']:
        ensure  => installed,
        require => Exec['apt-get update'],
    }

}