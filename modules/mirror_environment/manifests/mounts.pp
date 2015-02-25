# == Class: mirror_environment::mounts
#
# Configures LVM disks and mounts them
#
# === Parameters
#
# [*mirror_data*]
#   Root directory for the mounted disk
#
# [*username*]
#  Owner of the data directory and sub directories
#
class mirror_environment::mounts (
  $mirror_data,
  $username,
) {

  if ($::environment != 'development') {
    ext4mount { $mirror_data:
      mountoptions => 'defaults',
      disk         => '/dev/mapper/mirror-data',
      before       => File[$mirror_data],
      require      => [Lvm::Volume['data'], File[$mirror_data]],
    }

    lvm::volume { 'data':
      ensure => present,
      pv     => '/dev/sdb1',
      vg     => 'mirror',
      fstype => 'ext4',
    }
  }

  file { $mirror_data:
    ensure => directory,
    owner  => $username,
  }
}
