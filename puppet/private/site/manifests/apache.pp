class site::apache {
  class { '::apache': }

  apache::module { 'rewrite': }
  apache::listen { '0.0.0.0:80': }
}