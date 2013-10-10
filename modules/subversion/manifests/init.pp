class subversion {

  package { 'subversion':
    ensure => present,
    require => Exec['apt_update']
  }

}