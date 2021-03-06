class php5 {
  apt::source { 'dotdeb':
    location   => 'http://packages.dotdeb.org',
    release    => 'squeeze',
    repos      => 'all',
    key        => '89DF5277',
    key_server => 'keys.gnupg.net'
  }

  class { 'php':
    version => 'latest',
    require => [Apt::Source['dotdeb']]
  }

  editfile::config { "enable-html-errors":
    path    => '/etc/php5/apache2/php.ini',
    entry   => 'html_errors',
    ensure  => 'On',
    quote   => false,
    require => [Class['php']],
    notify  => [Service['apache2']]
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
  php::module { "mcrypt": }
}