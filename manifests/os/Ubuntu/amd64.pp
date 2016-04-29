class base::os::ubuntu::amd64 {

  apt::source { 'ubuntu':
    comment  => 'Ubuntu APT Repo',
    location => 'http://us.archive.ubuntu.com/ubuntu/',
    release  => $::lsbdistcodename,
    repos    => 'main restricted universe',
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