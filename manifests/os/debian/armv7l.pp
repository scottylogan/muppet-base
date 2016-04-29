class base::os::debian::armv7l {

  apt::source { 'raspbian':
    comment  => 'Raspbian APT Repo',
    location => 'http://mirrordirector.raspbian.org/raspbian/',
    release  => $::lsbdistcodename,
    repos    => 'contrib firmware main non-free rpi',
    key      => {
      'source' => 'http://mirrordirector.raspbian.org/raspbian.public.key',
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
      'source' => 'https://archive.raspberrypi.org/debian/raspberrypi.gpg.key',
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
      'source' => 'https://packagecloud.io/gpg.key',
    },
    include  => {
      'deb' => true,
    },
  }

}