# == Class: base::users
#
# Virtual user configuration for muppets.
#
# === Parameters
#
# none
#
# === Variables
#
# none
#
# === Examples
#
#  include muppet
#
# === Authors
#
# Scotty Logan <scotty@scottylogan.com>
#
# === Copyright
#
# Copyright 2016 Scotty Logan
#
class base::users (
  $managehome = false,
) {

  group { 'root':
    gid    => 0,
    system => true,
  }

  group { 'parents':
    gid => 32000,
  }

  group { 'kids':
    gid => 32001,
  }

  group { 'family':
    gid => 32002,
  }

  @group { 'scotty':
    gid => 1000,
    tag => [sysadmin, parent],
  }
  
  @user { 'scotty':
    comment        => 'Scotty Logan',
    home           => '/home/scotty',
    managehome     => $managehome,
    shell          => '/bin/bash',
    uid            => 1000,
    gid            => 1000,
    groups         => [ 'root', 'sudo', 'parents', 'family' ],
    purge_ssh_keys => true,
    tag            => [sysadmin, dev, parent],
  }

  @ssh_authorized_key { 'scotty@catbert.net-rsa':
    user => 'scotty',
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDfQMtTWOMOoCfp2OX8pPFzr7Uqzh8xTP9Ie1nJOI/3hEafpn2vwvoC2ZOZSQYP+Ux6Ev9DSsuPJizjGHFxu33FAZLPbe8nfG6voEnKcgrSMgd4He8k7gxOpWhrKS5UFfOYAqjqNkD2bQYJBOsi5GFBkBvcQPCuA4jFJz+4rFkAdd2/LRAv9E1tEBQ8Az6dO+NOc7dtX/VqZynLD/jIqsHTgdcI7qEwFdage3pnITlbuITTUosN+dngrQg4KHx0O8/sJQgyT6hunvMOanrgXXUq+KSkG1No0p+jLRH0FeEMPqcwDKzoREiZ8lblyfdiKjYIqeNCuOClAPnZrvyJVi4W6soyc2f3V1hbv5FFZi96h+4AKyOJgOc8RLP1Q8klD60weK9FJIoQBmUJNmG6bGTweG3IpKd51vPYMGXgEgV3lmmw+kAfVF+wnJpYHAs8jINun6uipWgzgqezNiEc/UaJGfapTH9PWISYYxNG00i577fZ9DE//rW0eIKvUc5JGnK514SAmSvFlJ1vIiX7h/d2Kx/PgYH+qDcd0wUxLgy6borjYW/TBvC0VuzRostwFBzGJxbz/yidqIgtJAbjdgD8qkzfX4abn5GxznS94RGQiC0p+P3yJ1NPA/Vubl+FUB37djhS/dPnCegoewBpS+9rHxvcZ78jKcYgkPSBtVEqdQ==',
    tag  => [sysadmin, dev, parent],
  }

  @ssh_authorized_key { 'scotty@catbert.net-ecdsa':
    user => 'scotty',
    type => 'ecdsa-sha2-nistp521',
    key  => 'AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAGGfra6d60+fDGHpoCdbILkpI21uE5c7jKDK6ZwAj+BiobIbuk9CBOmpwysSgL5PJCg80Y5yup7ORwdhnTfEz2tNQH9pF2TAA2QUC4HWXIBsk8SyL8VB4PjTQTaA5LqLQfJDsriOp0LRbkEHavE0yXhuRwOSAe3B1wpSScXcmCi0o4sdg==',
    tag  => [sysadmin, dev, parent],
  }

  @group { 'heather':
    gid => 1001,
    tag => [parent],
  }
  
  @user { 'heather':
    comment        => 'Heather Logan',
    home           => '/home/heather',
    managehome     => $managehome,
    shell          => '/bin/bash',
    uid            => 1001,
    gid            => 1001,
    groups         => [ 'parents', 'family' ],
    purge_ssh_keys => true,
    tag            => [parent],
  }

  @group { 'caitlin':
    gid => 1002,
    tag => [kid],
  }
  
  @user { 'caitlin':
    comment        => 'Caitlin Logan',
    home           => '/home/caitlin',
    managehome     => $managehome,
    shell          => '/bin/bash',
    uid            => 1002,
    gid            => 1002,
    groups         => [ 'kids', 'family' ],
    purge_ssh_keys => true,
    tag            => [kid],
  }

  @group { 'cerys':
    gid => 1003,
    tag => [kid],
  }
  
  @user { 'cerys':
    comment        => 'Cerys Logan',
    home           => '/home/cerys',
    managehome     => $managehome,
    shell          => '/bin/bash',
    uid            => 1003,
    gid            => 1003,
    groups         => [ 'kids', 'family' ],
    purge_ssh_keys => true,
    tag            => [kid],
  }

}