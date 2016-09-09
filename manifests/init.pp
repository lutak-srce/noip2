#
# = Class: noip2
#
# Installs service for updating dynamic IP, similar
# to DynDNS but free.
class noip2 (
  $source_noip2_conf = 'puppet:///modules/noip2/noip2.conf'
) {

  File {
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
  }

  file { '/etc/noip2.conf':
    mode   => '0600',
    source => $source_noip2_conf,
  }

  file { '/usr/local/bin/noip2':
    source => 'puppet:///modules/noip2/noip2.bin',
  }
  
  file { '/etc/init.d/noip2':
    source => 'puppet:///modules/noip2/noip2.rhel.sysv',
  }

  service { 'noip2':
    ensure  => running,
    enable  => true,
    require => File['/etc/init.d/noip2', '/usr/local/bin/noip2'],
  }

}
