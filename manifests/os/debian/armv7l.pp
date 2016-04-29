class base::os::debian::armv7l {

  apt::source { 'raspbian':
    comment  => 'Raspbian APT Repo',
    location => 'http://mirrordirector.raspbian.org/raspbian/',
    release  => $::lsbdistcodename,
    repos    => 'contrib firmware main non-free rpi',
    key      => {
      'id'     => 'A0DA38D0D76E8B5D638872819165938D90FDDD2E',
      'server' => 'keyserver.ubuntu.com',
    },
    include  => {
      'deb' => true,
    },
  }
  
  apt::source { 'raspberrypi':
    comment  => 'Raspberry Pi Foundation APT Repo',
    location => 'https://archive.raspberrypi.org/debian/',
    release  => $::lsbdistcodename,
    repos    => 'main ui',
    key      => {
      'id'     => 'CF8A1AF502A2AA2D763BAE7E82B129927FA3303E',
      'server' => 'keyserver.ubuntu.com',
    },
    include  => {
      'deb' => true,
    },
  }

  apt::source { 'docker':
    comment  => 'Docker armhf APT Repo',
    location => 'https://packagecloud.io/Hypriot/Schatzkiste/debian/',
    release  => $::lsbdistcodename,
    repos    => 'main',
    key      => {
      'id'     => '418A7F2FB0E1E6E7EABF6FE8C2E73424D59097AB',
      'server' => 'keyserver.ubuntu.com',
    },
    include  => {
      'deb' => true,
    },
  }

}