# base

#### Table of Contents

1. [Description](#description)
1. [Setup](#setup)
    * [What base affects](#what-base-affects)
    * [Setup requirements](#setup-requirements)
1. [Usage](#usage)
1. [Limitations](#limitations)
1. [Development](#development)

## Description

This module provides a consistent base configuration for Muppets. I use it mostly with Raspberry Pis,
but also Debian Jessie and Ubuntu Trusty EC2 instances and Docker containers (it's a variant of a
module I wrote for work, where we mostly use Docker containers running on EC2 instances).

In addition, it has some support for Darwin (macOS Sierra; it may work on earlier systems).

The module ensures that a base set of packages is installed, including

* bash
* bc
* bzip2
* ca-certificates
* curl
* git
* gzip
* less
* logrotate
* lsof
* man-db
* openssh-server
* rsyslog
* tzdata
* unzip
* wget

Additional packages are installed depending on the type of image being
built; for example, non-Docker images also include

* cloud-init
* ethtool
* iptables
* ntp
* ntpdate
* pciutils

(or their equivalents).

## Setup

### What base affects

*base* sets up APT or HomeBrew repos, installs common packages,
and configures the timezone (default is PST8PDT) and locale (default is
en_US).

### Setup requirements

Puppet 4.x must already be installed for *base* to work. Extra Puppet
module requirements are defined in _metadata.json_ and _Puppetfile_, so
`librarian-puppet` should be used to ensure all module dependencies are
resolved.

## Usage

Configuration is managed by Hiera, using the data files under _data_
and the hierarchy defined in _hiera.yaml_.

If new packages are required they should be added to
`base::packages::install` - in _common.yaml_ if the package name is
generic, or in the appropriate YAML file for specific OSes or platforms.

To exclude packages for some platforms, add those package names to
`base::packages::uninstall` in the appropriate YAML file.

## Limitations

*base* has been tested on Debian Jessie, Ubuntu Trusty, and macOS
Sierra; basic testing has also been done on the other OSes.

## Development

Submit issues / merge requests on
[github.com](https://github.com/scottylogan/muppet-base/).





