class mysql 
{
    $mysqlUsername = "root"
    $mysqlPassword = "root"
 
    package 
    { 
        "mysql-server":
            ensure  => present,
            require => Exec['apt-get update']
    }

    service 
    { 
        "mysql":
            enable => true,
            ensure => running,
            require => Package["mysql-server"],
    }

    exec 
    { 
        "set-mysql-password":
            unless => "mysqladmin -u$mysqlUsername -p$mysqlPassword status",
            command => "mysqladmin -u$mysqlUsername password $mysqlPassword",
            require => Service["mysql"],
    }

    file
    {
        '/home/vagrant/.my.cnf':
            content => template("mysql/my.cnf.erb"),
            require => Exec['set-mysql-password']
    }
}