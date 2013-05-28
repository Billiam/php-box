class git {

  package { 'git':
    ensure => present,
    require => Exec['apt-get update']
  }

  package { 'git-doc':
    ensure => present
  }

  package { 'git-svn':
    ensure => present
  }
}