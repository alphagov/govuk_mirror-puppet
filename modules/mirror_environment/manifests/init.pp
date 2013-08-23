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
  $package_array = []
) {

  if ( $package_array != [] ) {
    package { $package_array:
      ensure => present,
    }
  }
}
