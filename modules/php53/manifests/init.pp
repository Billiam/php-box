class php53 {
    apt::source { 'dotdeb':
      location   => 'http://packages.dotdeb.org',
      release    => 'squeeze',
      repos      => 'all',
      key        => '89DF5277',
      key_server => 'keys.gnupg.net'
    }

    class { 'php':
        package => ['php5-cli', 'php5-common'],
        version => 'latest',
        #      augeas => true,
        config_file => '/etc/php5/conf.d/php-puppet.ini',
        require => [Apt::Source['dotdeb']]
    }

    php::module { 'dev': }
    php::module { 'xsl': }
    php::module { 'apc': }
    php::module { 'pgsql': }
    php::module { 'mysql': }
    php::module { 'xdebug': }
    php::module { 'gd': }
    php::module { 'curl': }
    php::module { "imagick": }

        # PEAR
    include pear

    pear::package { 'PEAR':
        version => latest,
        require => Class['php']
    }

    pear::package { 'phing':
      version => latest,
      repository => 'pear.phing.info',
      require => Pear::Package['PEAR']
    }
}