# == Class: mount
#
# Module for mounting the mirror data disks
# It won't apply to Vagrant
#
class mount {
  if ($::environment != 'development') {
    ext4mount { '/srv/mirror_data':
      mountoptions => 'defaults',
      disk         => '/dev/sdb1',
    }
  }
}
