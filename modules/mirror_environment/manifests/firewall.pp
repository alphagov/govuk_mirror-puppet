# == Class: mirror_environment::firewall
#
# Configures ufw - allows port 22 for SSH.
#
#
class mirror_environment::firewall {

  ufw::allow { 'allow-ssh':
    port => '22',
    ip   => 'any'
  }

  ufw::allow { 'allow-https':
    port => '443',
    ip   => 'any'
  }
}
