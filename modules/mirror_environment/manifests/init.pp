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

  # FIXME Remove once deployed
  exec { 'Rename wildcard SSL certificate':
    command => 'mv /etc/nginx/ssl/{www-origin,mirror}.cert;
      mv /etc/nginx/ssl/{www-origin,mirror}.key',
    onlyif  => 'test -f /etc/nginx/ssl/www-origin.cert',
    before  => Class['nginx'],
  }

  package{ 'ssl-cert':
    ensure => present,
  } ->
  file{ '/etc/ssl/private/ssl-cert-snakeoil.key': } ->
  file{ '/etc/ssl/certs/ssl-cert-snakeoil.pem': }

  nginx::resource::vhost{ 'default_server':
      www_root             => '/usr/share/nginx/html',
      listen_options       => ' default_server',
      location_cfg_prepend =>  {
        'return' => '444 "no content"',
      },
      ssl                  => true,
      ssl_key              => '/etc/ssl/private/ssl-cert-snakeoil.key',
      ssl_cert             => '/etc/ssl/certs/ssl-cert-snakeoil.pem',
      ssl_protocols        => 'TLSv1 TLSv1.1 TLSv1.2',
  }

}
