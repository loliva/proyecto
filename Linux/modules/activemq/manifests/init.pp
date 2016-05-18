class activemq ($discover) {
  package { "activemq":
    ensure  => latest,
    #require => Class['java8']
  } ->
  file { '/etc/activemq/activemq.xml':
    content => template('activemq/activemq.xml.erb'),
    notify  => Service['activemq']
  } ->
  file { '/etc/activemq/log4j.properties':
    source  => 'puppet:///modules/activemq/log4j.properties',
    notify  => Service['activemq']
  } ->
  service { "activemq":
    ensure => running,
    enable => true,
  }

}