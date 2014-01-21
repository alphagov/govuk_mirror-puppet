# == Class: mirror_environment::mounts
#
# Configures LVM disks, mounts them and ensures the mirror_data and
# www_roots exist
#
# === parameters
#
# [*mirror_data*]
#   Root directory for the mounted disk
#
# [*username*]
#  Owner of the data directory and sub directories
#
# [*www_roots*]
#   WWW root directories to have their existance ensured
#
class mirror_environment::mounts (
  $mirror_data,
  $username,
  $www_roots = [],
) {

  if ($::environment != 'development') {
    ext4mount { $mirror_data:
      mountoptions => 'defaults',
      disk         => '/dev/mapper/mirror-data',
      before       => File[$mirror_data],
      require      => Lvm::Volume['data'],
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

  if ( $www_roots != [] ) {
    file { $www_roots:
      ensure => directory,
      owner  => $username,
    }
  }

}
