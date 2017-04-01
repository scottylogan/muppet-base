# == Class: muppet::brew
#
# Generic Homebrew configuration for a Muppet
#
# === Authors
#
# Scotty Logan <swl@scottylogan.com>
#
class muppet::brew (
  $sources, # dummy
  $taps,
  $casks,
){

  include stdlib

  class { 'homebrew': }

  # install taps before everything else
  # install brews before casks
  Package <| provider == tap |>  -> Package <| provider == brew |>
  Package <| provider == tap |>  -> Package <| provider == brewcask |>
  Package <| provider == brew |> -> Package <| provider == brewcask |>

  ensure_packages($taps, {
    ensure   => present,
    provider => tap,
  })
  ensure_packages($casks, {
    ensure   => present,
    provider => brewcask,
    require  => Package['caskroom/casks'],
  })

  # Puppet installer adds path to puppet, but not
  # to additional gems, so add that
  file { '/etc/paths.d/puppet-base':
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => '/opt/puppetlabs/puppet/bin',
  }

}
