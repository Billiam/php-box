class site_tmux {
  tmux::config {'normal':
    target => '/home/vagrant/.tmux.conf',
    owner => 'vagrant',
  }
}
