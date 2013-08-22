# == Class: mirror_environment::mounts
#
# Configures mount and ensures the data_dir and www_roots
# exist
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
      disk         => '/dev/mapper/vg0-lv0',
      before       => File[$data_dir],
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
