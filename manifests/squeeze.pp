class squeeze {

  Exec { path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games' }

  group { 'puppet':
    ensure => present
  }

  exec { 'apt-get update':
    command => 'sudo /usr/bin/apt-get update'
  }

  include git
  include subversion

  include php53
  
  class { 'apache':
    default_vhost => false,
  }

  exec {"vagrant www-data membership":
    unless => 'groups vagrant | grep -q "\bwww-data\b"',
    command => "usermod -aG www-data vagrant",
    require => [Class['apache']]
  }

  apache::listen { '192.168.56.21:80': }

  include composer

  editfile::config { "enable_adminer":
    path   => '/etc/php5/cli/conf.d/suhosin.ini',
    entry  => 'suhosin.executor.include.whitelist',
    ensure => 'phar',
    quote  => false,
    require => [Class['composer']]
  }
  
  include mysql
  include postgres
  include adminer::apache
  include site_tmux
}
include squeeze
