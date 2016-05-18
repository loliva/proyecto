class httpd_web () {
  include stdlib

  host { 'www.gps.entel.cl': ip => '127.0.0.1', }

  host { 'entelgps.entel.cl': ip => '127.0.0.1', }

  host { 'apps.gps.cl': ip => '127.0.0.1', }

  host { 'maps.gps.cl': ip => '127.0.0.1', }

  host { 'rslite.gps.cl': ip => '127.0.0.1', }

  host { 'tastets.tms.gps.cl': ip => '127.0.0.1', }

  host { 'rastreosat.tms.gps.cl': ip => '127.0.0.1', }

  host { 'rslite.tms.gps.cl': ip => '127.0.0.1', }

  host { 'analytics.rastreosat.cl': ip => '127.0.0.1', }

  host { 'rsl.gps.cl': ip => '127.0.0.1', }

  package { ['httpd', 'mod_ssl', 'openssl']: ensure => installed, }

  notify { 'copy_files':
    require => [
      Package['httpd'],
      Package['mod_ssl'],
      Package['openssl']],
  }

  file { "/etc/httpd/conf/httpd.conf":
    source  => "puppet:///modules/httpd_web/httpd.conf",
    recurse => true,
    require => Notify['copy_files'],
    notify  => Service['httpd'],
  }

  file { "/etc/httpd/conf/entelgps.entel.cl.crt":
    source  => "puppet:///modules/httpd_web/entelgps.entel.cl.crt",
    recurse => true,
    require => Notify['copy_files'],
    notify  => Service['httpd'],
  }

  file { "/etc/httpd/conf/entelgps.entel.cl.key":
    source  => "puppet:///modules/httpd_web/entelgps.entel.cl.key",
    recurse => true,
    require => Notify['copy_files'],
    notify  => Service['httpd'],
  }

  file { "/etc/httpd/conf/magic":
    source  => "puppet:///modules/httpd_web/magic",
    recurse => true,
    require => Notify['copy_files'],
    notify  => Service['httpd'],
  }

  file { "/etc/httpd/conf/www.gps.entel.cl.crt":
    source  => "puppet:///modules/httpd_web/www.gps.entel.cl.crt",
    recurse => true,
    require => Notify['copy_files'],
    notify  => Service['httpd'],
  }

  file { "/etc/httpd/conf/www.gps.entel.cl.key":
    source  => "puppet:///modules/httpd_web/www.gps.entel.cl.key",
    recurse => true,
    require => Notify['copy_files'],
    notify  => Service['httpd'],
  }

  service { 'httpd':
    ensure => running,
    enable => true,
  }

}