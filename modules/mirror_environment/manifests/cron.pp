# == Class: mirror_environment::cron
#
# Configure the system crontab; also purges unmanaged
# cron entries.
#
# === Parameters
#
# [*daily_minute*]
#  Specifies the minute in the hour at which cron.daily will run.
#  Default: 0
#
# [*daily_hour*]
#  Specifies the hour at which cron.daily will run.  Important because it
#  determines when unattended-upgrades will run, and consequently the time at
#  which automatic reboots may occur.
#  Default: 10
#
class mirror_environment::cron
(
  $daily_minute = 0,
  $daily_hour = 10
) {
  resources { 'cron':
    purge => true,
  }

  service { 'cron':
    ensure => running,
  }

  validate_bool(is_integer($daily_minute))
  validate_bool(is_integer($daily_hour))

  file {'/etc/crontab':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('mirror_environment/etc/crontab.erb'),
    notify  => Service['cron'],
  }
}
