class elasticsearch {
 include stdlib
 
 file { '/etc/yum.repos.d/elasticsearch.repo':
        owner => root,
        group => root,
        mode => '0644',
        source => 'puppet:///modules/elasticsearch/elasticsearch.repo',
      }
 
   
 package { 'elasticsearch' :
      ensure => installed,
      require => File['/etc/yum.repos.d/elasticsearch.repo'],
      }
    
 file_line { '/etc/elasticsearch/elasticsearch.yml':
        ensure => present,
        path   => '/etc/elasticsearch/elasticsearch.yml',
        line   => 'network.host: localhost',
        match  => '#?network.host: localhost',
        require => [Package['elasticsearch']],
        notify => Service['elasticsearch'],
      }
    
 service { 'elasticsearch':
      ensure => "running",
      enable => true,
      require => Class['java8'],
      }
}