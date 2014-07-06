Exec { path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games' }

exec { 'apt-get update':
  command => 'sudo /usr/bin/apt-get update'
}

import "nodes"