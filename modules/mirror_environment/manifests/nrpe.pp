# == Class: mirror_environment::nrpe
#
# This class defines NRPE commands to be used with the pdxcat/nrpe module
# this repository uses.
#
# === Parameters
#
# [*mirror_data_mountpoint*]
#   The mount point for the data that the mirrors serve.
#

class mirror_environment::nrpe (
  $mirror_data_mountpoint,
){

  nrpe::command {'check_disk':
    ensure  => present,
    command => 'check_disk -w 10% -c 5%',
  }

  nrpe::command {'check_disk_mirror-data':
    ensure  => present,
    command => "check_disk -w 10% -c 5% ${mirror_data_mountpoint}",
  }

}
