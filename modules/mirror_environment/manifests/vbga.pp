# == Class: mirror_environment::vbga:
#   - Install current kernel's Linux headers
#   - Install Dynamic Kernel Module Support (DKMS)
#   - Re-compile VirtualBox Guest Additions

class mirror_environment::vbga {

  package {[
            'dkms',
            'linux-headers-$(uname -r)',
          ]:
    ensure => 'present',
  }

  exec { 'recompile-kernel-module':
    command => 'sudo /etc/init.d/vboxadd setup',
  }
}
