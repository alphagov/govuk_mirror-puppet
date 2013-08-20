# == Class: mirror_environment
#
# Module for mirror environment specific stuff
#
# === parameters
#
# [*package_array*]
#   Array of packages to install. Defaults to empty array and no action.
#
class mirror_environment (
  $data_dir,
  $package_array = []
) {
  if ( $package_array != [] ) {
    package { $package_array:
      ensure => present,
    }
  }

  if ($::environment != 'development') {
    ext4mount { '/srv/mirror_data':
      mountoptions => 'defaults',
      disk         => '/dev/mapper/vg0-lv0',
    }
  }
}
