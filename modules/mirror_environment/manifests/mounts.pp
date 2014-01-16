# == Class: mirror_environment::mounts
#
# Configures LVM disks, mounts them and ensures the data_dir and
# www_roots exist
#
# === parameters
#
# [*data_dir*]
#   Root directory for the mounted disk
#
# [*username*]
#  Owner of the data directory and sub directories
#
# [*www_roots*]
#   WWW root directories to have their existance ensured
#
class mirror_environment::mounts (
  $data_dir,
  $username,
  $www_roots = [],
) {

  if ($::environment != 'development') {
    ext4mount { $data_dir:
      mountoptions => 'defaults',
      disk         => '/dev/mapper/data-dir',
      before       => File[$data_dir],
      require      => Lvm::Volume['data-dir'],
    }

    lvm::module { 'data-dir':
      ensure => present,
      pv     => '/dev/sdb1',
      vg     => 'data-dir',
      fstype => 'ext4',
    }
  }

  file { $data_dir:
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
