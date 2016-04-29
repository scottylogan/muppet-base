class base::os::debian::amd64 {

  apt::source { 'debian':
    comment  => 'Debian APT Repo',
    location => 'http://httpredir.debian.org/debian',
    release  => $::lsbdistcodename,
    repos    => 'main contrib non-free',
    include  => {
      'deb' => true,
    },
  }

  apt::source { 'debian-updates':
    comment  => 'Debian Updates APT Repo',
    location => 'http://httpredir.debian.org/debian',
    release  => "${::lsbdistcodename}-updates",
    repos    => 'main contrib non-free',
    include  => {
      'deb' => true,
    },
  }

  apt::source { 'debian-security':
    comment  => 'Debian Security APT Repo',
    location => 'http://security.debian.org/',
    release  => "${::lsbdistcodename}/updates",
    repos    => 'main contrib non-free',
    include  => {
      'deb' => true,
    },
  }

  apt::source { 'docker':
    comment  => 'Docker APT Repo',
    location => 'https://apt.dockerproject.org/repo/',
    release  => downcase("${::operatingsystem}-${::lsbdistcodename}"),
    repos    => 'main',
    key      => {
      'id'     => '58118E89F3A912897C070ADBF76221572C52609D',
      'server' => 'keyserver.ubuntu.com',
    },
    include  => {
      'deb' => true,
    },
  }

}