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
  $timezone,
  $locale,
  $lang,
  $charset,
  $add_cloud_config,
) {

  include base::packages

  if ($add_cloud_config) {

    file { '/etc/cloud/cloud.cfg':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      source  => "puppet:///modules/${module_name}/cloud.cfg",
      require => Package['cloud-init'],
    }

  }

  file { '/etc/timezone':
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0444',
    content => $timezone,
  }

  if ($::osfamily != 'Darwin') {

    file { '/etc/localtime':
      ensure  => link,
      owner   => 0,
      group   => 0,
      mode    => '0644',
      target  => "/usr/share/zoneinfo/${timezone}",
      require => Package['tzdata'],
    }

    file { '/etc/default/locale':
      ensure => file,
      owner  => 0,
      group  => 0,
      mode   => '0444',
      source => "puppet:///modules/${module_name}/etc/default/locale",
    }

  } else {

    file { '/etc/localtime':
      ensure  => link,
      owner   => 0,
      group   => 0,
      mode    => '0644',
      target  => "/usr/share/zoneinfo/${timezone}",
    }

  }

  if ($::osfamily == 'Debian') {
    file { '/etc/locale.gen':
      ensure  => file,
      owner   => 0,
      group   => 0,
      mode    => '0444',
      content => "${locale} ${charset}",
    }

    exec { 'locale-gen':
      command     => '/usr/sbin/locale-gen',
      subscribe   => File['/etc/locale.gen'],
      refreshonly => true,
    }
  }

  include base::users

  Group <| tag == sysadmin |>
  User  <| tag == sysadmin |>
  File  <| tag == sysadmin |>
}

