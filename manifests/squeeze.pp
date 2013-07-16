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

  exec { "/bin/chown root:www-data /var/www":
    unless => "/bin/sh -c '[ $(/usr/bin/stat -c %G /var/www) == www-data ]'",
  }
  exec { "/bin/chmod 755 /var/www":
    unless => "/bin/sh -c '[ $(/usr/bin/stat -c %a /var/www) == 755 ]'",
  }

  exec {"vagrant www-data membership":
    unless => 'groups vagrant | grep -q "\bwww-data\b"',
    command => "usermod -aG www-data vagrant",
    require => [Class['apache']]
  }

  apache::listen { '192.168.56.21:80': }


  include mysql
  include postgres
  include adminer::apache
  include site_tmux
}
include squeeze