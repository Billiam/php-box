#!/bin/bash

# Directory in which librarian-puppet should manage its modules directory
PUPPET_DIR='/vagrant/puppet'

sudo chmod -R ug+rwX $PUPPET_DIR

source /etc/profile.d/chruby.sh
chruby 2.1.2

if [ `gem query --local | grep librarian-puppet | wc -l` -eq 0 ]; then
  echo 'Installing librarian puppet'
  gem install librarian-puppet --no-ri --no-rdoc
  cd $PUPPET_DIR && librarian-puppet install --clean
else
  echo 'Updating librarian puppet'
  cd $PUPPET_DIR && librarian-puppet update
fi

sudo chmod -R ug+rwX $PUPPET_DIR
