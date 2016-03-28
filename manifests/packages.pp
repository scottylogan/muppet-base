# == Class: muppet
#
# Full description of class muppet here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'muppet':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Scotty Logan <scotty@scottylogan.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class muppet::packages {

  package {
    [
      'bash',
      'bash-completion',
      'bc',
      # dig, nslookup
      'dnsutils',
      'curl',
      'git',
      'less',
      'lsof',
      'vim-tiny',

      'lsb-base',
      'lsb-release',
      'adduser',
      'apt',
      'apt-transport-https',

      'ca-certificates',
      'cron',
      'ethtool',
      'firmware-linux-free',
      'iptables',
      'isc-dhcp-client',
      'logrotate',
      'manpages',
      'ntp',
      'ntpdate',
      'openssh-client',
      'openssh-server',
      'puppet',
      'rsyslog',

      'bzip2',
      'gzip',
      'xz-utils',
      'unzip',
      'zip',
    ]:
    ensure => latest,
  }


  if $::hardwaremodel == 'x86_64' {
    package {
      [
        'pciutils',
      ]:
      ensure => latest,
    }
  }

  # use vim.tiny as the default editor
  file { '/etc/alternatives/editor':
    ensure  => link,
    target  => '/usr/bin/vim.tiny',
    require => Package['vim-tiny'],
  }

  # packages I don't want
  package {
    [
      'nano',
    ]:
    ensure  => absent,
    require => File['/etc/alternatives/editor'],
  }

}
