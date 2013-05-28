class postgres {
  $username = "root"
  $password = "root"

  package { 'postgresql-8.4':
    ensure => present,
    require => Exec['apt-get update']
  }

  package { 'libpq-dev':
    ensure => present,
    require => Exec['apt-get update']
  }

  service { 'postgresql':
    ensure => running,
    require => Package['postgresql-8.4', 'libpq-dev']
  }

  # Create database user if it doesn't already exist
  exec { 'create_db_user':
    command => "sudo -u postgres createuser -d -l -S -r $username && sudo -u postgres psql -tAc \"ALTER USER $username WITH ENCRYPTED PASSWORD '$password'\"",
    unless  => "sudo -u postgres psql -tAc \"SELECT 1 FROM pg_roles WHERE rolname='$username'\" | grep -q 1",
    require => Service['postgresql'],
  }

  # Create database if it doesn't already exist
  #exec { 'create_user':
  #  command => "sudo -u postgres createdb -O $username $database",
  #  unless  => "sudo -u postgres psql -tAc \"SELECT 1 FROM pg_catalog.pg_database WHERE datname='$database'\" | grep -q 1",
  #require => [ Exec['create_db_user'], Service['postgresql'] ],
  #}
}
