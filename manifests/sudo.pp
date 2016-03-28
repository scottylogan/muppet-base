# == Class: muppet::sudo
#
# Sudo configuration for muppets
#
# === Parameters
#
# none
#
# === Variables
#
# none
#
# === Examples
#
#  include muppet::sudo
#
# === Authors
#
# Scotty Logan <scotty@scottylogan.com>
#
# === Copyright
#
# Copyright 2016 Scotty Logan
#
class muppet::sudo {

  package { 'sudo':
    ensure  => latest,
  }
  
  file { '/etc/sudoers':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    source  => "puppet:///modules/${module_name}/etc/sudoers",
    require => Package['sudo'],
  }
  
  file { '/etc/sudoers.d':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    require => Package['sudo'],
  }
  
  file { '/etc/sudoers.d/root':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    content => '%root	ALL=(ALL) NOPASSWD: ALL',
    require => File['/etc/sudoers.d'],
  }
}
