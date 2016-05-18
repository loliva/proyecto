
class splunk {
  exec{'download_splunk':
    command => "/usr/bin/wget -O /tmp/splunklight-6.4.0.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=6.4.0&product=splunk_light&filename=splunklight-6.4.0-f2c836328108-Linux-x86_64.tgz&wget=true'",
    creates => "/tmp/splunklight-6.4.0.tgz",
    timeout => 0,
   }
  exec {'tar_splunk':
    command => "/bin/tar -zxvf /tmp/splunklight-6.4.0.tgz -C /opt/; /bin/touch /opt/splunk_installed",
    creates => "/opt/splunk_installed",
    timeout => 7200,
    require => Exec['download_splunk'],
   }
  
  exec { "mkdir_local":
    command => "/bin/mkdir -p /opt/splunk/etc/apps/search/local",
  }
  
  exec {'touch_props':
    command => "/bin/touch /opt/splunk/etc/apps/search/local/props.conf",
    creates => "/opt/splunk/etc/apps/search/local/props.conf",
    timeout => 7200,
    require => Exec['mkdir_local'],
   }
   
  exec {'touch_inputs':
    command => "/bin/touch /opt/splunk/etc/apps/search/local/inputs.conf",
    creates => "/opt/splunk/etc/apps/search/local/inputs.conf",
    timeout => 7200,
    require => Exec['mkdir_local'],
   }
  
   file { "/opt/splunk/etc/apps/search/local/props.conf":
    source => 'puppet:///modules/splunk/props.conf.rb',
    require => Exec['touch_inputs'],
   }
    
  file { "/opt/splunk/etc/apps/search/local/inputs.conf":
    source => 'puppet:///modules/splunk/inputs.conf.rb',
    require => Exec['touch_inputs'],
   }
   
  exec {'enable':
    command => "/opt/splunk/bin/splunk enable boot-start; /bin/touch /opt/splunk/enable_boot",
    creates => "/opt/splunk/enable_boot",
    timeout => 7200,
    require => Exec['touch_inputs'],
   }
  
  exec {'license':
    command => "/opt/splunk/bin/splunk start --accept-license; /bin/touch /opt/splunk/license_acceptd",
    creates => "/opt/splunk/license_acceptd",
    timeout => 0,
    require => Exec['touch_inputs'],
   }
      
  service { 'splunk':
      ensure => "running",
      enable => true,
      require => Exec['license'],
   }

}
