class xdebug {
  file { "/etc/php5/apache2/conf.d/xdebug-settings.ini":
    ensure => present,
    source => "puppet:///modules/xdebug/xdebug.ini",
    notify => [Service["apache2"]],
    require => [Exec['create-cachegrind']]
  }

  exec { "create-cachegrind":
  	command => "mkdir -p /var/www/debug/cachegrind",
  	creates => "/var/www/debug/cachegrind"
  }	
  exec { 'download-webgrind':
    cwd     => '/tmp',
    command => 'wget https://webgrind.googlecode.com/files/webgrind-release-1.0.zip',
    creates => '/var/www/debug/index.php'
  }
  exec { 'extract-webgrind':
    cwd     => '/tmp',
    command => 'unzip webgrind-release-1.0.zip',
    require => Exec['download-webgrind'],
    creates => '/var/www/debug/index.php'
  }
  exec { 'move-webgrind':
    command => "cp -r /tmp/webgrind/* /var/www/debug/",
    creates => "/var/www/debug/index.php",
    require => [ Exec['extract-webgrind'], Exec['create-cachegrind'] ]
  }
  apache::vhost { 'webgrind':
    docroot             => '/var/www/debug',
    directory           => '/var/www/debug',
    server_name         => 'webgrind.dev',
    priority            => '',
    directory_options   => '-Indexes FollowSymLinks -MultiViews',
    require             => [ Exec['move-webgrind'] ]
  }
}