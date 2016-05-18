class logstash {
 
    file { '/etc/yum.repos.d/logstash.repo':
        owner => root,
        group => root,
        mode => '0644',
        source => 'puppet:///modules/logstash/logstash.repo',
    }
  
    package { 'logstash' :
      ensure => installed,
      require => File['/etc/yum.repos.d/logstash.repo'],
    }
          
    file { "/etc/logstash/conf.d/01-lumberjack-input.conf":
      mode    => '0644',
      owner => root,
      group => root,
      source => 'puppet:///modules/logstash/01-lumberjack-input.conf',
      require => Package['logstash'],
      
    }
    
    file { "/etc/logstash/conf.d/10-syslog.conf":
      mode    => '0644',
      owner => root,
      group => root,
      source => 'puppet:///modules/logstash/10-syslog.conf',
      require => Package['logstash'],
     
    }
    
    file { "/etc/logstash/conf.d/30-lumberjack-output.conf":
      mode    => '0644',
      owner => root,
      group => root,
      source => 'puppet:///modules/logstash/30-lumberjack-output.conf',
      require => Package['logstash'],   
    }
    
      service { 'logstash':
      ensure => "running",
      enable => true,
      require => Class['java8'],
    }
}