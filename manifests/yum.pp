# == Class: muppet::yum
#
# Generic YUM configuration for a Muppet
#
# === Authors
#
# Scotty Logan <swl@scottylogan.com>
#
class muppet::yum(
  $sources,
) {

  validate_hash($sources)

  if $sources {
    create_resources('yumrepo', $sources)
  }
  
  # Generate locale files

  file { '/etc/locale.conf':
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0444',
    content => "LANG=\"${muppet::locale}\"",
  }

  exec { 'locale-def':
    command     => "/usr/bin/localedef -v -c -i ${muppet::lang} -f ${muppet::charset} ${muppet::locale}",
    subscribe   => File['/etc/locale.conf'],
    refreshonly => true,
    returns     => [ 0, 1 ],
  }
}
