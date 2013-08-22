# == Class: mirror_environment
#
# Module for mirror environment specific stuff
#
# === parameters
#
# [*package_array*]
#   Array of packages to install. Defaults to empty array and no action.
#
# [*ssl_config*]
#   A hash of vhost name to ssl $cert and $key.
#
class mirror_environment (
  $package_array = [],
  $ssl_config = {}
) {

  if ( $package_array != [] ) {
    package { $package_array:
      ensure => present,
    }
  }

  file { '/etc/nginx/ssl':
    ensure => directory,
    mode   => '0700',
    purge  => true,
  }

  validate_hash($ssl_config)
  create_resources('mirror_environment::nginx_ssl', $ssl_config)

}
