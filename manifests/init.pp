# == Class: base
#
# Base configuration for a Muppet.
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
class base (
  $timezone,
  $locale,
  $lang,
  $charset,
  $add_cloud_config,
  $avahi,
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

  if ($avahi) {
    file { '/etc/avahi/avahi-daemon.conf':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      source  => "puppet:///modules/${module_name}/etc/avahi/avahi-daemon.conf",
      require => Package['avahi-daemon'],
    }

    file { '/etc/nsswitch.conf':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      source  => "puppet:///modules/${module_name}/etc/nsswitch.conf",
      require => Package['avahi-daemon','libnss-mdns'],
    }
  }

  file { '/etc/timezone':
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0444',
    content => $timezone,
  }

  file { '/etc/localtime':
    ensure => link,
    owner  => 0,
    group  => 0,
    mode   => '0644',
    target => "/usr/share/zoneinfo/${timezone}",
  }

  if ($::osfamily != 'Darwin') {

    file { '/etc/default/locale':
      ensure => file,
      owner  => 0,
      group  => 0,
      mode   => '0444',
      source => "puppet:///modules/${module_name}/etc/default/locale",
    }

  }

  include base::users

  Group <| tag == sysadmin |>
  User  <| tag == sysadmin |>
  File  <| tag == sysadmin |>
}

