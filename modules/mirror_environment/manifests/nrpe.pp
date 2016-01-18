# == Class: mirror_environment::nrpe
#
# This class defines NRPE commands to be used with the pdxcat/nrpe module
# this repository uses.

class mirror_environment::nrpe{

  nrpe::command {'check_disk':
    ensure  => present,
    command => 'check_disk -w 10% -c 5%',
  }
}
