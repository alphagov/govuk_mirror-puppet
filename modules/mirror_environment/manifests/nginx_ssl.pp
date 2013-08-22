# == Class: mirror_environment::nginx_ssl
#
# Resource for creating ssl keys and certs for nginx
#
# === parameters
#
# [*key*]
#   A String containing the private key
#
# [*cert*]
#   A String containing the public certificate
#
define mirror_environment::nginx_ssl (
  $key,
  $cert
) {

  $directory = '/etc/nginx/ssl'

  file { "${directory}/${name}.cert":
    ensure  => present,
    content => $cert,
    mode    => '0444',
    notify  => Class['nginx::service'],
  }

  file { "${directory}/${name}.key":
    ensure  => present,
    content => $key,
    mode    => '0400',
    notify  => Class['nginx::service'],
  }

}
