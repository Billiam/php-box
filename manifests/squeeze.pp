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
  apache::listen { '192.168.56.21:80': }


  include mysql
  include postgres
  include adminer::apache
  include site_tmux
}
include squeeze