class base::os::debian {

  apt::source { 'nodesource':
    comment  => 'NodeSource APT Repo',
    location => 'https://deb.nodesource.com/node_4.x',
    release  => $::lsbdistcodename,
    repos    => 'main',
    key      => {
      'id'     => '9FD3B784BC1C6FC31A8A0A1C1655A0AB68576280',
      'server' => 'keyserver.ubuntu.com',
    },
    include  => {
      'deb' => true,
    },
  }

  apt::setting { 'conf-muppet':
    priority => 50,
    source   => "puppet:///modules/${module_name}/etc/apt/apt.conf.d/50muppet",
  }

  contain "base::os::debian::${::architecture}"
}