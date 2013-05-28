class adminer {
    define get_plugin($url, $name) {
        exec{"get_${name}":
            command => "wget ${url} -O /var/www/adminer/plugins/${name}.php",
            creates => "/var/www/adminer/plugins/${name}.php",
            require => File['/var/www/adminer/plugins']
        }
    }

    file { ['/var/www', '/var/www/adminer']:
        ensure => directory
    }
    file { '/var/www/adminer/plugins':
        ensure => directory,
        require => File['/var/www/adminer']
    }
    exec{"download_adminer":
        command => "wget http://www.adminer.org/latest-en.php -O /var/www/adminer/latest.php",
        creates => '/var/www/adminer/latest.php',
        require => File['/var/www/adminer']
    }
    exec{"download_skin":
        command => "wget https://raw.github.com/vrana/adminer/master/designs/brade/adminer.css -O /var/www/adminer/adminer.css",
        creates => '/var/www/adminer/adminer.css',
        require => File['/var/www/adminer']
    }
    file { '/var/www/adminer/index.php':
        content => template("adminer/index.erb"),
        require => File['/var/www/adminer']
    }

    get_plugin{ 'plugin': url => 'https://raw.github.com/vrana/adminer/master/plugins/plugin.php', name => 'plugin' }
    get_plugin{ 'edit-foreign': url => 'https://raw.github.com/vrana/adminer/master/plugins/edit-foreign.php', name => 'edit-foreign' }
    get_plugin{ 'convention-foreign-keys': url => 'https://gist.github.com/raw/821510/convention-foreign-keys.php', name => 'convention-foreign-keys' }
}