# == Class: base::packages
#
# Generic package installation for a Muppet
#
# === Authors
#
# Scotty Logan <swl@scottylogan.com>
#
class base::packages (
  $install,
  $uninstall,
  $pip,
  $easy_install,
  $package_type,
  $sources,
){

  include stdlib

  Package { provider => $package_type }

  class { "base::${package_type}":
    sources => $sources
  }

  $only_install = difference($install, $uninstall)

  $installing = join($only_install, ' ')
  $uninstalling = join($uninstall, ' ')

  ensure_packages($only_install, { ensure => present })
  ensure_packages($uninstall, { ensure => absent })

  if ($::osfamily == 'Debian') {
    exec { 'apt-mark':
      command => "/usr/bin/apt-mark manual ${installing}",
      require => Package[$only_install],
    }
  }

  if member($only_install, 'sudo') {
    file { '/etc/sudoers':
      ensure  => file,
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
  }

}
