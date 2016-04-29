class base::os::ubuntu {

  apt::source { 'nodesource':
    comment  => 'NodeSource APT Repo',
    location => 'https://deb.nodesource.com/node_4.x',
    release  => $::lsbdistcodename,
    repos    => 'main',
    key      => {
      'source' => 'https://deb.nodesource.com/gpgkey/nodesource.gpg.key',
    },
    include  => {
      'deb' => true,
    },
  }

  apt::setting { 'conf-muppet':
    priority => 50,
    source   => "puppet:///modules/${module_name}/etc/apt/apt.conf.d/50muppet",
  }

  contain "base::os::ubuntu::${::architecture}"
}