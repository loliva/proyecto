class nginx ($services, $service_port = "80",) {
  $nginx_base = "/etc/nginx"
  $nginx_confd = "${nginx_base}/conf.d"
  $nginx_upstream = "${nginx_confd}/upstream"
  $nginx_reverse_proxy = "${nginx_confd}/reverse_proxy"

  case $::operatingsystem {
    'CentOS' : {
      file { '/etc/yum.repos.d/nginx.repo':
        owner  => root,
        group  => root,
        mode   => '0644',
        source => 'puppet:///modules/nginx/nginx-centos.repo',
      }
    }
    'RedHat' : {
      file { '/etc/yum.repos.d/nginx.repo':
        owner  => root,
        group  => root,
        mode   => '0644',
        source => 'puppet:///modules/nginx/nginx-rhel.repo',
      }
    }
  }

  package { 'nginx':
    ensure  => installed,
    require => File['/etc/yum.repos.d/nginx.repo'],
  }

  service { 'nginx':
    ensure  => "running",
    enable  => true,
    require => Package['nginx'],
  }

  # CREAR CARPETAS
  exec { "create_${nginx_base}":
    command => "/bin/mkdir -p ${nginx_base}",
    creates => "${nginx_base}",
  }

  file { "$nginx_confd":
    ensure  => "directory",
    require => Exec["create_${nginx_base}"],
  }

  file { "$nginx_upstream":
    ensure  => "directory",
    require => Exec["create_${nginx_base}"],
  }

  file { "$nginx_reverse_proxy":
    ensure  => "directory",
    require => Exec["create_${nginx_base}"],
  }

  # CONFIG NECESARIAS
  file { "${nginx_upstream}/upstream.conf":
    mode    => '0644',
    content => template('nginx/upstream-conf.erb'),
    require => [Package['nginx']],
    notify  => [Service['nginx']],
  }

  file { "${nginx_reverse_proxy}/server.conf":
    mode    => '0644',
    content => template('nginx/server-conf.erb'),
    require => [Package['nginx']],
    notify  => [Service['nginx']],
  }

  file { "${nginx_base}/nginx.conf":
    mode    => '0644',
    content => template('nginx/nginx-conf.erb'),
    require => [Package['nginx']],
    notify  => [Service['nginx']],
  }

  file { "${nginx_confd}/default.conf":
    mode    => '0644',
    content => template('nginx/default-erb'),
    require => [Package['nginx']],
    notify  => [Service['nginx']],
  }

  file { "${nginx_base}/reverse_proxy_params":
    mode    => '0644',
    content => template('nginx/proxy_params-conf.erb'),
    require => [Package['nginx']],
    notify  => [Service['nginx']],
  }
  
  file { "${nginx_base}/proxy_params":
    mode    => '0644',
    content => template('nginx/proxy_params.erb'),
    require => [Package['nginx']],
    notify  => [Service['nginx']],
  }

  # BORRA CONF INNECESARIAS
  file { "$nginx_confd/example_ssl.conf":
    ensure  => absent,
    require => [Package['nginx']],
  }

  # monit para nginx
  file { "/etc/monit.d/nginx":
    content => template('nginx/monit-nginx.erb'),
    notify  => Service['monit'],
    require => [Package['monit']],
  }
}