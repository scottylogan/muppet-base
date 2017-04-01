# == Class: muppet::apt
#
# Generic APT configuration for a Muppet
#
# === Authors
#
# Scotty Logan <swl@scottylogan.com>
#
class muppet::apt(
  $sources,
) {

  package {
    [
      'apt',
      'apt-transport-https',
    ]:
    ensure => latest,
  }

  class { 'apt':
    update  => {
      frequency => 'daily',
    },
    purge   => {
      'sources.list'   => true,
      'sources.list.d' => true,
    },
    sources => $sources,
  }

  # force apt-get update before package installation
  Class['apt::update'] -> Package<| |>

  apt::setting { 'conf-muppet':
    priority => 50,
    source   => "puppet:///modules/${module_name}/etc/apt/apt.conf.d/50muppet",
  }

  # Generate locale files

  file { '/etc/locale.gen':
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0444',
    content => "${muppet::locale} ${muppet::charset}",
  }

  exec { 'locale-gen':
    command     => '/usr/sbin/locale-gen',
    subscribe   => File['/etc/locale.gen'],
    refreshonly => true,
  }

}
