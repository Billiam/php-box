class adminer::apache inherits adminer {
    apache::vhost { 'default':
        port            => 80,
        add_listen      => false,
        docroot         => '/var/www/adminer',
        require         => [File['/var/www/adminer/index.php']],
    }
}