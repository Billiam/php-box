class site::nodejs {
  class { '::nodejs':
    version      => 'stable',
    make_install => false,
  }

  package { 'grunt-cli':
    provider => npm,
    require => Class['::nodejs']
  }
}
