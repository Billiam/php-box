class adminer::lighttp inherits adminer {
    editfile::config { "enable_adminer":
        path   => '/etc/lighttpd/lighttpd.conf',
        entry  => 'server.document-root',
        ensure => '/var/www/adminer',
        quote  => true,
        require => [File['/var/www/adminer/index.php'], Package['lighttpd']],
        notify  => Service["lighttpd"]
    }

    package { "php5-pgsql":
        ensure  => present,
        require => [Package['php5-common'], Exec['apt-get update']]
    }

    package { "php5-mysql":
        ensure  => present,
        require => [Package['php5-common'], Exec['apt-get update']]
    }
}