class httpd ($backends, $virtualhosts) {
  package { 'httpd': ensure => installed, }
  include stdlib
#  package { 'mod_ssl': ensure => installed, }

#  package { 'openssl': ensure => installed, }

#  file { "/etc/httpd/cert":
#    recurse => true,
#    source  => 'puppet:///modules/httpd/cert',
#    require => [Package['httpd'], Package['mod_ssl'], Package['openssl']],
#    notify  => Service['httpd'],
#  }



  file { "/etc/httpd/conf.d/ssl.conf":
    ensure  => absent,
    require => [Package['httpd']], #Package['mod_ssl'], Package['openssl']],
    notify  => Service['httpd'],
  }

  file { "/etc/httpd/conf.d/gps.conf":
    content => template('httpd/gps.conf.erb'),
    require => [Package['httpd']],# Package['mod_ssl'], Package['openssl']],
    notify  => Service['httpd'],
  }

  file { "/etc/httpd/conf.d/port81.conf":
    source  => 'puppet:///modules/httpd/port81.conf',
    require => [Package['httpd']],#, Package['mod_ssl'], Package['openssl']],
    notify  => Service['httpd'],
  }

  file { "/etc/httpd/conf/httpd.conf":
    source  => 'puppet:///modules/httpd/httpd.conf',
    require => [Package['httpd']], #Package['mod_ssl'], Package['openssl']],
    notify  => Service['httpd'],
  }
  
  file_line { '/etc/sysconfig/httpd worker enable':
        ensure => present,
        path   => '/etc/sysconfig/httpd',
        line   => 'HTTPD=/usr/sbin/httpd.worker',
        match  => '#?HTTPD=/usr/sbin/httpd.worker',
        require => [Package['httpd']],
        notify => Service['httpd'],
  }

  service { 'httpd':
    ensure  => running,
    enable  => true,
    require => [Package['httpd']], #Package['mod_ssl'], Package['openssl']],
  }

}