# == Class: packages
#
# Simple module that installs packages from a hash
#
class packages (
  $package_array = []
) {

  if ( $package_array != [] ) {
    package { $package_array:
      ensure => present,
    }
  }
}
