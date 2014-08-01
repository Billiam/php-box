node 'php.dev' {

  group { 'puppet':
    ensure => present
  }
  exec {"vagrant www-data membership":
    unless => 'groups vagrant | grep -q "\bwww-data\b"',
    command => "usermod -aG www-data vagrant",
    require => [Class['site::apache']]
  }

  class { 'apt':
    always_apt_update    => true
  }

  include git
  include php5
  include composer
  include site::tmux
  include site::bash
  include site::apache
  include site::nodejs
  include mysql
  include postgres

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