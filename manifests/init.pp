# == Class: base
#
# Base configuration for muppets.
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
#  include muppet
#
# === Authors
#
# Scotty Logan <scotty@scottylogan.com>
#
# === Copyright
#
# Copyright 2016 Scotty Logan
#
class base (
  $timezone = 'PST8PDT',
  $locale   = 'en_US.UTF-8'
) {

  class { 'apt':
    update => {
      frequency => 'daily',
    },
    purge  => {
      'sources.list'   => true,
      'sources.list.d' => true,
    }
  }

  include base::os::${operatingsystem}
  include base::packages
  include base::sudo
  include base::users

  file { '/etc/localtime':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0444',
    source => "/usr/share/zoneinfo/${timezone}",
  }

  file { '/etc/timezone':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => $timezone,
  }
  
  file { '/etc/default/locale':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0444',
    source => "puppet:///modules/${module_name}/etc/default/locale",
  }
  
  file { '/etc/locale.gen':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => "${locale} UTF-8",
  }
  
  exec { 'locale-gen':
    command     => '/usr/sbin/locale-gen',
    subscribe   => File['/etc/locale.gen'],
    refreshonly => true,
  }


  Group <| tag == sysadmin |>
  User  <| tag == sysadmin |>
  File  <| tag == sysadmin |>
}

