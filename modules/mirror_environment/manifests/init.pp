# == Class: mirror_environment
#
# Module for mirror environment specific stuff
#
# === parameters
#
# [*data_dir*]
#   Root directory for the mounted disk
#
# [*package_array*]
#   Array of packages to install. Defaults to empty array and no action.
#
class mirror_environment (
  $data_dir,
  $www_roots = [],
  $package_array = []
) {
  if ( $package_array != [] ) {
    package { $package_array:
      ensure => present,
    }
  }

  if ($::environment != 'development') {
    ext4mount { $data_dir:
      mountoptions => 'defaults',
      disk         => '/dev/mapper/vg0-lv0',
      before       => File[$data_dir],
    }
  }

  file { $data_dir:
    ensure => directory,
  }

  if ( $www_roots != [] ) {
    file { $www_roots:
      ensure => directory,
    }
  }

}
