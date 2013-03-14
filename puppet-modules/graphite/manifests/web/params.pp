class graphite::web::params {

    $apache_user               = 'www-data'
    $apache_group              = 'www-data'
    $apache_site               = '/etc/apache2/sites-available/default'
    $user                      = 'www-data'
    $group                     = 'www-data'
    $graphite_python_path      = '/usr/share/pyshared/graphite'

    # Apache-WSGI
    $name_virtual_host         = '*:80'
    $wsgi_socket_prefix        = 'run/wsgi'
    $server_name               = 'graphite'
    $document_root             = '/var/lib/graphite/webapp'
    $error_log                 = '/var/lib/graphite/storage/log/webapp/error.log'
    $custom_log                = '/var/lib/graphite/storage/log/webapp/access.log common'
    $wsgi_daemon_process       = 'graphite processes=5 threads=5 display-name=\'%{GROUP}\' inactivity-timeout=120'
    $wsgi_process_group        = 'graphite'
    $wsgi_application_group    = '%{GLOBAL}'
    $wsgi_import_script_path   = '/var/lib/graphite/conf/'
    $wsgi_import_script        = '/var/lib/graphite/conf/graphite.wsgi'
    $wsgi_script_alias         = '/'
    $content_alias             = '/content/'
    $content_path              = '/var/lib/graphite/webapp/content/'
    $media_alias               = '/media/'
    $media_path                = '/usr/lib/python2.7/dist-packages/django/contrib/admin/media/'

    #Django
    $timezone                  = 'Europe/London'
    $documentation_url         = 'http://graphite.readthedocs.org/' #
    $log_rendering_performance = 'False' #
    $log_cache_performance     = 'False' #
    $log_metric_access         = 'False' #
    $debug_error_pages         = 'True' #
    $flush_rrd_cached          = '' # 'unix:/var/run/rrdcached.sock' #
    $memcache_hosts            = [] #['10.10.10.10:11211', '10.10.10.11:11211', '10.10.10.12:11211'] #
    $memcache_default_duration = '60' #
    $conf_dir                  = '/var/lib/graphite/conf'
    $storage_dir               = '/var/lib/graphite/storage'
    $content_dir               = '/var/lib/graphite/webapp/content'
    $dashboard_conf            = '/var/lib/graphite/conf/dashboard.conf' #
    $graph_templates_conf      = '/var/lib/graphite/conf/graphTemplates.conf' #
    $whisper_dir               = '/var/lib/graphite/storage/whisper'
    $rrd_dir                   = '/var/lib/graphite/storage/rrd'
    $data_dirs                 = [$whisper_dir, $rrd_dir]
    $log_dir                   = '/var/lib/graphite/storage/log/webapp'
    $index_file                = '/var/lib/graphite/storage/index'
    $email_backend             = 'django.core.mail.backends.dummy.EmailBackend' #'django.core.mail.backends.smtp.EmailBackend' #
    $email_host                = 'localhost' #
    $email_port                = '25' #
    $email_host_user           = '' #
    $email_host_password       = '' #
    $email_use_tls             = 'False' #
    $use_ldap_auth             = 'False' #
    $ldap_uri                  = 'ldaps://ldap.mycompany.com:639' #
    $ldap_search_base          = 'OU=users,DC=mycompany,DC=com' #
    $ldap_base_user            = 'CN=some_readonly_account,DC=mycompany,DC=com' #
    $ldap_base_password        = 'readonly_account_password' #
    $ldap_user_query           = '(sAMAccountName=%s)' #AD
    $use_remote_user_auth      = 'False' #
    $login_url                 = '/account/login' #
    $db_name                   = '/var/lib/graphite/storage/graphite.db' #
    $db_engine                 = 'django.db.backends.sqlite3' #
    $db_user                   = '' #
    $db_password               = '' #
    $db_host                   = '' #
    $db_port                   = '' #
    $cluster_servers           = [] #['10.0.2.2:80','10.0.2.3:80'] #
    $cluster_fetch_timeout     = '6' #
    $cluster_find_timeout      = '2.5' #
    $cluster_retry_delay       = '60' #
    $cluster_cache_duration    = '300' #
    $remote_rendering          = 'False' #
    $remote_rendering_hosts    = [] #
    $remote_render_con_timeout = '1.0' #
    $local_carbon_instances    = ['127.0.0.1:7002:default','127.0.0.1:7102:b','127.0.0.1:7202:c'] #
    $local_carbon_timeout      = '1.0' #
}
