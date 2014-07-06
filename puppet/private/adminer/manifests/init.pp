class adminer {
    define get_plugin($url, $name) {
        exec{"get_${name}":
            command => "wget ${url} -O /var/www/adminer/plugins/${name}.php --no-check-certificate",
            creates => "/var/www/adminer/plugins/${name}.php",
            require => File['/var/www/adminer/plugins']
        }
    }

    file { '/var/www':
        ensure => directory
    }
    file { '/var/www/adminer':
        ensure => directory,
        require => File['/var/www']
    }
    exec { "/bin/chown root:www-data /var/www":
      unless => "/bin/sh -c '[ $(/usr/bin/stat -c %G /var/www) == www-data ]'",
      require => [File['/var/www']]
    }
    exec { "/bin/chmod 755 /var/www":
      unless => "/bin/sh -c '[ $(/usr/bin/stat -c %a /var/www) == 755 ]'",
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
        command => "wget https://raw.githubusercontent.com/vrana/adminer/master/designs/brade/adminer.css -O /var/www/adminer/adminer.css --no-check-certificate",
        creates => '/var/www/adminer/adminer.css',
        require => File['/var/www/adminer']
    }
    file { '/var/www/adminer/index.php':
        content => template("adminer/index.erb"),
        require => File['/var/www/adminer']
    }

    get_plugin{ 'plugin': url => 'https://raw.githubusercontent.com/vrana/adminer/master/plugins/plugin.php', name => 'plugin' }
    get_plugin{ 'edit-foreign': url => 'https://raw.githubusercontent.com/vrana/adminer/master/plugins/edit-foreign.php', name => 'edit-foreign' }
    get_plugin{ 'convention-foreign-keys': url => 'https://gist.githubusercontent.com/iNecas/821510/raw/convention-foreign-keys.php', name => 'convention-foreign-keys' }
}