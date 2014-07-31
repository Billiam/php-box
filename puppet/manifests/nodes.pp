node 'php.dev' {

  group { 'puppet':
    ensure => present
  }
  exec {"vagrant www-data membership":
    unless => 'groups vagrant | grep -q "\bwww-data\b"',
    command => "usermod -aG www-data vagrant",
    require => [Class['apache']]
  }

  class { 'apt':
    always_apt_update    => true
  }

  include git
  include php5
  include composer
  include site::tmux
  include site::bash
  include mysql
  include postgres

  class { 'nodejs':
    version      => 'stable',
    make_install => false,
  }
  class { 'apache':
    puppi => true,
  }

  include adminer::apache

  class { "xdebug":
    require => [Class['php5']]
  }

  editfile::config { "enable_adminer":
    path   => '/etc/php5/cli/conf.d/suhosin.ini',
    entry  => 'suhosin.executor.include.whitelist',
    ensure => 'phar',
    quote  => false,
    require => [Class['composer']]
  }
}