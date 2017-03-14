class base::apt(
  $sources,
) {

  package {
    [
      'apt',
      'apt-transport-https',
    ]:
    ensure => latest,
  }

  class { 'apt':
    update  => {
      frequency => 'daily',
    },
    purge   => {
      'sources.list'   => true,
      'sources.list.d' => true,
    },
    sources => $sources,
  }

  # force apt-get update before package installation
  Class['apt::update'] -> Package<| |>

  apt::setting { 'conf-muppet':
    priority => 50,
    source   => "puppet:///modules/${module_name}/etc/apt/apt.conf.d/50muppet",
  }

}
