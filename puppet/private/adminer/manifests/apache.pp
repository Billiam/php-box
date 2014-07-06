class adminer::apache inherits adminer {
    apache::vhost { 'default':
        docroot             => '/var/www/adminer',
        directory           => '/var/www/adminer',
        server_name         => false,
        priority            => '',
        directory_options   => '-Indexes FollowSymLinks -MultiViews'
    }
}