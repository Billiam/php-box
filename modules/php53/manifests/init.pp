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


    # upgrade pear
    exec {"pear upgrade":
      command => "/usr/bin/pear upgrade",
      require => Class['php'],
      returns => [ 0, '', ' ']
    }

    # set channels to auto discover
    exec { "pear auto_discover" :
      command => "/usr/bin/pear config-set auto_discover 1",
      require => [Class['php']]
    }

    exec { "pear update-channels" :
      command => "/usr/bin/pear update-channels",
      require => [Class['php']]
    }
    
    exec {"pear install phing":
      command => "/usr/bin/pear install --alldeps pear.phing.info/phing",
      creates => '/usr/bin/phing',
      require => Exec['pear update-channels'],
      returns => [ 0, '', ' ']
    }
}