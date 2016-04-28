# == Class: muppet
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
class muppet (
  $timezone = 'PST8PDT',
  $locale   = 'en_US.UTF-8'
) {
  include muppet::packages
  include muppet::sudo
  include muppet::users

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
  
  file { '/etc/auto.master':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source => "puppet:///modules/${module_name}/etc/auto.master",
  }

  file { '/etc/auto.home':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source => "puppet:///modules/${module_name}/etc/auto.home",
  }

  exec { 'locale-gen':
    command     => '/usr/sbin/locale-gen',
    subscribe   => File['/etc/locale.gen'],
    refreshonly => true,
  }

  Group              <| tag == sysadmin |>
  User               <| tag == sysadmin |>
  File               <| tag == sysadmin |>
  Ssh_Authorized_Key <| tag == sysadmin |>
}

