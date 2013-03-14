class graphite::web::install(

    $user                      = $graphite::web::params::user,
    $group                     = $graphite::web::params::group,
    $graphite_python_path      = $graphite::web::params::graphite_python_path,
    $timezone                  = $graphite::web::params::timezone,
    $documentation_url         = $graphite::web::params::documentation_url,
    $log_rendering_performance = $graphite::web::params::log_rendering_performance,
    $log_cache_performance     = $graphite::web::params::log_cache_performance,
    $log_metric_access         = $graphite::web::params::log_metric_access,
    $debug_error_pages         = $graphite::web::params::debug_error_pages,
    $flush_rrd_cached          = $graphite::web::params::flush_rrd_cached,
    $memcache_hosts            = $graphite::web::params::memcache_hosts,
    $memcache_default_duration = $graphite::web::params::memcache_default_duration,
    $conf_dir                  = $graphite::web::params::conf_dir,
    $storage_dir               = $graphite::web::params::storage_dir,
    $content_dir               = $graphite::web::params::content_dir,
    $dashboard_conf            = $graphite::web::params::dashboard_conf,
    $graph_templates_conf      = $graphite::web::params::graph_templates_conf,
    $whisper_dir               = $graphite::web::params::whisper_dir,
    $rrd_dir                   = $graphite::web::params::rrd_dir,
    $data_dirs                 = $graphite::web::params::data_dirs,
    $log_dir                   = $graphite::web::params::log_dir,
    $index_file                = $graphite::web::params::index_file,
    $email_backend             = $graphite::web::params::email_backend,
    $email_host                = $graphite::web::params::email_host,
    $email_port                = $graphite::web::params::email_port,
    $email_host_user           = $graphite::web::params::email_host_user,
    $email_host_password       = $graphite::web::params::email_host_password,
    $email_use_tls             = $graphite::web::params::email_use_tls,
    $use_ldap_auth             = $graphite::web::params::use_ldap_auth,
    $ldap_uri                  = $graphite::web::params::ldap_uri,
    $ldap_search_base          = $graphite::web::params::ldap_search_base,
    $ldap_base_user            = $graphite::web::params::ldap_base_user,
    $ldap_base_password        = $graphite::web::params::ldap_base_password,
    $ldap_user_query           = $graphite::web::params::ldap_user_query,
    $use_remote_user_auth      = $graphite::web::params::use_remote_user_auth,
    $login_url                 = $graphite::web::params::login_url,
    $db_name                   = $graphite::web::params::db_name,
    $db_engine                 = $graphite::web::params::db_engine,
    $db_user                   = $graphite::web::params::db_user,
    $db_password               = $graphite::web::params::db_password,
    $db_host                   = $graphite::web::params::db_host,
    $db_port                   = $graphite::web::params::db_port,
    $cluster_servers           = $graphite::web::params::cluster_servers,
    $cluster_fetch_timeout     = $graphite::web::params::cluster_fetch_timeout,
    $cluster_find_timeout      = $graphite::web::params::cluster_find_timeout,
    $cluster_retry_delay       = $graphite::web::params::cluster_retry_delay,
    $cluster_cache_duration    = $graphite::web::params::cluster_cache_duration,
    $remote_rendering          = $graphite::web::params::remote_rendering,
    $remote_rendering_hosts    = $graphite::web::params::remote_rendering_hosts,
    $remote_render_con_timeout = $graphite::web::params::remote_render_con_timeout,
    $local_carbon_instances    = $graphite::web::params::local_carbon_instances,
    $local_carbon_timeout      = $graphite::web::params::local_carbon_timeout,

    ) inherits graphite::web::params {

    include 'graphite::common::install'

    package { [ 'python-graphite-web']:
        ensure  => latest,
        require => Exec['apt-get update'],
    }

    file { "${graphite_python_path}/local_settings.py":
        ensure  => present,
        content => template('graphite/web/local_settings.py.erb'),
        owner   => 'root',
        group   => 'root',
        require => Package['python-graphite-web'],
    }

    file { $index_file:
        ensure  => present,
        owner   => $user,
        group   => $group,
        require => Package['python-graphite-web'],
    }

    file { $storage_dir:
        ensure  => directory,
        owner   => $user,
        group   => $group,
        require => Package['python-graphite-web'],
    }

    file { $log_dir:
        ensure  => directory,
        owner   => $user,
        group   => $group,
        require => Package['python-graphite-web'],
    }

    exec { 'syncdb':
        command => "/usr/bin/python ${graphite_python_path}/manage.py syncdb --noinput",
        cwd     => $graphite_python_path,
        require => Package['python-graphite-web'],
        creates => $db_name,
    }

    case $db_engine {
        'django.db.backends.sqlite3': {
            file { $db_name:
                ensure  => present,
                owner   => $user,
                group   => $group,
                mode    => '0664',
                require => Exec['syncdb'],
            }
        }
        default: {}
    }

}