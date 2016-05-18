class kibana {
  include stdlib
  
  $kibana_base = "/opt/kibana"
  account { 'kibana': 
              uid => 1005,
              home_dir => '/home/kibana',
              groups => [ 'kibana' ], 
              ensure => present,
           }
  
  exec {'download_kibana':
    #command => "/usr/bin/wget -nc https://download.elastic.co/kibana/kibana/kibana-4.2.0-linux-x64.tar.gz -O /opt/kibana.tgz",
    command => "/usr/bin/wget -nc http://chileweb.cl/~loliva/kibana.tgz -O /opt/kibana.tgz",
    timeout => 7200,
    }

  exec {'tar_kibana':
    command => "/bin/tar -zxvf /opt/kibana.tgz -C /opt/",
    timeout => 7200,
   }
   
   file { $kibana_base:
    ensure => 'link',
    target => '/opt/kibana-4.2.0-linux-x64',
    mode => '0755',
    owner => kibana,
    group => kibana,
    replace => "yes",
    require => Exec['tar_kibana'],
  }
   
   exec { 'chmod_kibana':
     command => "/bin/chmod -Rv 755 /opt/kibana-4.2.0-linux-x64",
     require => Exec['tar_kibana'],
   }  
   
   exec { 'chow_kibana':
     command => "/bin/chown -Rv kibana:kibana /opt/kibana-4.2.0-linux-x64",
     require => Exec['tar_kibana'],
   }

  file_line { 'mod_kibana':
    ensure => present,
    path   => '/opt/kibana/config/kibana.yml',
    line => 'server.host: "0.0.0.0"',
    match  => '# server.host: "0.0.0.0"',
    require => Exec['tar_kibana'],
   }
   
   file { "/etc/init.d/kibana":
    source => 'puppet:///modules/kibana/kibana.init',
    mode    => '0755',
    owner => root,
    group => root,
   }
   
   file { "/etc/default/kibana":
    source => 'puppet:///modules/kibana/kibana.default',
    mode    => '0644',
    owner => root,
    group => root,
   }
   
   service { 'kibana':
      ensure => "running",
      enable => true,
   }

}







