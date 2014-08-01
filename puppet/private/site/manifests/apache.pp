class site::apache {
  class { '::apache':
    puppi => true,
  }
  apache::module { 'rewrite': }
  apache::listen { '0.0.0.0:80': }
}