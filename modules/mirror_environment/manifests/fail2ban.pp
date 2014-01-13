# == Class: mirror_environment::fail2ban
#
# Installs fail2ban for IP blacklisting
#
class mirror_environment::fail2ban (
  $whitelist_ips = ['127.0.0.1'],
) {
  include ::fail2ban

  file { '/etc/fail2ban/jail.local':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('mirror_environment/etc/fail2ban/jail.local.erb'),
    notify  => Service['fail2ban'],
    # Require package rather than class to avoid dependency issues
    # incurred by the Fail2Ban module we are using.
    require => Package['fail2ban'],
  }
}
