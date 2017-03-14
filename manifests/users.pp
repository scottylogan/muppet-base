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
    gid => 65536,
  }

  group { 'kids':
    gid => 65537,
  }

  group { 'family':
    gid => 65538,
  }

  @user { 'scotty':
    comment        => 'Scotty Logan',
    home           => '/home/scotty',
    managehome     => $managehome,
    shell          => '/bin/bash',
    uid            => 1026,
    gid            => 'family',
    groups         => [ 'root', 'sudo', 'parents' ],
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

  @ssh_authorized_key { 'swl-rsa':
    user => 'scotty',
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDKnStGpMBXtYrIxganjDHZYdIuF1PklIB0mzOpmMMVklLPhB9InUnicy6KCuGCXJlyesyE8fg3wEWImfXw5mentavXvallo5sbDp2DZTBg/AAmrJzr6So/Ly5U+Z2Fy/uieAK+u0ORekCGCQX2YlZQf0zlcYnHPnwHRfVSOVz9zSdtZ9QkQbTWvI/evVYQ1VTaJ77EKKMWY0E88lLOwytM1OkQMDc8bGp03ROj8HOE7aSfxT9veWN9Kx/nr0jNEzLPF6KeQEISk7+VbyvJN3T8tREOd3B+2AVynhQ9SSnDcFsjN8HAMoW3VWbH0b/2G+6B7eIZDtqbk4sFfqb8/74xeqyoUplQ2cvLdijO1oPXfSaKKKz2tgbleZ3DOQCLA8iSk8ykZr16Nb4nU2bb5ZNqvYJIl0oyIDLJEaoEsga4UWRgmV3xMQrtK+F9DXToW+Voim2EU9AHTIir4VHnktWQtxeeuSTToHMAIhlSWMUxUBw9SqLnwA1Dim6LzeJxawhGUGBFvFi+y28+mOtiFmsl7gum47MRDr2H1Aor9grrQ5Q2LseB2+3yjZRMDUrKcsIAFBJZwkeauVjXADCwem5SPZEfNX3zXjCXirEdWb7gBoVeslVslClvLDdSje04jDALpbHzgiSdQpau42JyJw+EEO/PGAvrRkP8vN6PDxE3OQ==',
    tag  => [sysadmin, dev, parent],
  }

  @ssh_authorized_key { 'swl-dsa':
    user => 'scotty',
    type => 'ssh-dss',
    key  => 'AAAAB3NzaC1kc3MAAACBAP4mOqwuv+OPI272hYBrRCS3T6AltQKfxRSkGB7F8iY9qJjkRjwLdscKWSaWnzD+4iANdmYw+SSMwlmQ+5wxLEr4RE1onYZC20VJSsSvqiAlstUD136p0UN7kacCJR4eB+hSuT3GY7kFNb2hJo/VlgTz1YBYoWmS2XFEKAi7ubfXAAAAFQDtcG89vTIBpvPk63QdqWhQIczWIwAAAIEAreX5zEDRAaPFSQ2XiF6oKAhXapkYIn6IqBlumV0dahWPSOUvKSlR+GJ3PxYNI/Dj06CwhEsH5rqWGAe9+NMYUFiEafPjAHc4CVbUv5cLhP5nmXsEEXuz2hFXIm4qpbN+Jl+95C8yVOpfh6liVNc5TTYZ2kburWR1iBK93HyB5F8AAACBANRxUvrFuumoNCuoc5jEPwDxT94RrDoaaKDAfQQwXCHLokgyBBk+uMMLHuZo7el3pBVZ7MDknalAGi2Rye8L51K+mP28DJkkjHTPwUxWUvkgKbfj0OOc+dCVsRxn+Vo74K1dGYTpRrIvfKrhymsgf4Bt6+nqkxfWONm53v9DUpfW',
    tag  => [sysadmin, dev, parent],
  }

  @user { 'heather':
    comment        => 'Heather Logan',
    home           => '/home/heather',
    managehome     => $managehome,
    shell          => '/bin/bash',
    uid            => 1027,
    gid            => 'family',
    groups         => [ 'parents' ],
    purge_ssh_keys => true,
    tag            => [parent],
  }

  @user { 'caitlin':
    comment        => 'Caitlin Logan',
    home           => '/home/caitlin',
    managehome     => $managehome,
    shell          => '/bin/bash',
    uid            => 1028,
    gid            => 'family',
    groups         => [ 'kids' ],
    purge_ssh_keys => true,
    tag            => [kid],
  }

  @user { 'cerys':
    comment        => 'Cerys Logan',
    home           => '/home/cerys',
    managehome     => $managehome,
    shell          => '/bin/bash',
    uid            => 1029,
    gid            => 'family',
    groups         => [ 'kids' ],
    purge_ssh_keys => true,
    tag            => [kid],
  }

}
