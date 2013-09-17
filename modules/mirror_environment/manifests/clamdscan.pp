# == Class: mirror_environment::clamdscan
#
# set up virus scanning of /srv
#
#
class mirror_environment::clamdscan {

  apparmor::profile { 'usr.sbin.clamd':
    local_only   => true,
    local_source => 'puppet:///modules/mirror_environment/etc/apparmor.d/local/usr.sbin.clamd',
    require      => Class['clamav'],
    }

  file { '/srv/infected':
    ensure => directory,
    }

  file { '/usr/local/sbin/scan-srv-mirror_data.sh':
    source  => 'puppet:///modules/mirror_environment/usr/local/sbin/scan-srv-mirror_data.sh',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Class['clamav'],
    }

  cron { 'clamdscan-srv-mirrordata':
    command     => '/usr/local/sbin/scan-srv-mirror_data.sh',
    minute      => fqdn_rand(60),
    require     => File['/usr/local/sbin/scan-srv-mirror_data.sh'],
    }
}
