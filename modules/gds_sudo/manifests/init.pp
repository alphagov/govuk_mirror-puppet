# == Class:gds_sudo
#
# Wrapper class for arnoudj/sudo
#
class gds_sudo (
  $sudoers = undef
) {

  class { 'sudo':
    sudoers         => $sudoers,
    manage_sudoersd => true,
    sudoers_file    => 'puppet:///modules/gds_sudo/sudoers.conf',
  }
}
