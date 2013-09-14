# == Class: mirror_environment::clamdscan
#
# set up virus scanning of /srv
#
#
class mirror_environment::clamdscan {

  file { '/etc/apparmor.d/local/usr.sbin.clamd':
    content => '/srv/** r,',
    }

  file { '/srv/infected':
    ensure => directory,
    }

  file { '/usr/local/sbin/scan-srv-mirror_data.sh':
    source => 'puppet:///modules/mirror_environment/usr/local/sbin/scan-srv-mirror_data.sh',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    }

  cron { 'clamdscan-srv-mirrordata':
    command     => '/usr/local/sbin/scan-srv-mirror_data.sh',
    minute      => fqdn_rand(60),
    }
}
