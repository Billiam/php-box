class site::bash {
  file_line { 'bash color terminal':
    path => '/home/vagrant/.bashrc',
    line => '    screen-256color|linux|cygwin|xterm-color) color_prompt=yes;;',
    match => '.*xterm-color.*\) color_prompt=yes;;'
  }
}