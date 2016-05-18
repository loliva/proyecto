class rsyslog {
  
          package { "rsyslog": ensure => "latest" }
          file { "/etc/rsyslog.conf":
               owner => 'root', group => 'root', mode => '0644',
               source => 'puppet:///modules/rsyslog/rsyslog.conf',
               before => Service["rsyslog"],
               notify => Service["rsyslog"]
          }
         
          service { "rsyslog":
            enable  => true,
            ensure  => running,
            require => Package["rsyslog"]
          } 
}

