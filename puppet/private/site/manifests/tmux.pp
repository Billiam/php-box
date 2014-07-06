class site::tmux {
  tmux::config {'tmux':
    target => '/home/vagrant/.tmux.conf',
    owner => 'vagrant',
    source => 'puppet:///modules/site/tmux'
  }

  file_line { 'tmux-bashrc':
    path => '/home/vagrant/.bashrc',
    line => 'test -z "$TMUX" && (tmux attach || tmux new-session)',
    match => '.*tmux attach.*'
  }
}
