# == Class: mirror_environment::clamdscan
#
# set up virus scanning of /srv
#
#
class mirror_environment::clamdscan {

  file { '/etc/apparmor.d/local/usr.sbin.clamd':
    content => '/srv/** r,',
    }

  cron { 'clamdscan-srv-mirrordata':
    command => '/usr/bin/clamdscan /srv/mirror_data/',
    minute  => fqdn_rand(60),
    }
}
