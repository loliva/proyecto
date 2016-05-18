class haproxy ($services, $service_port = "80", $monitor_port = "40004", $mode = "vhost") {
  package { 'haproxy': ensure => installed, }

  service { 'haproxy':
    ensure  => running,
    enable  => true,
    require => Package['haproxy'],
  }

  file { "/etc/haproxy/haproxy.cfg":
    mode    => '0644',
    content => template("haproxy/haproxy.${mode}.cfg.erb"),
    require => Package['haproxy'],
    notify  => Service['haproxy'],
  }

  file { "/etc/monit.d/haproxy":
    content => template('haproxy/monit-haproxy.erb'),
    notify  => Service['monit'],
    require => [Package['monit'], Package['haproxy']],
  }

}