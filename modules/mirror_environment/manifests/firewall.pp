# == Class: mirror_environment::firewall
#
# Configures ufw
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

  ufw::allow { 'allow-nrpe':
    port => '5666',
    ip   => 'any'
  }
}
