class ntps {
  include stdlib

  package { ['ntp', 'ntpdate']: 
      ensure => installed, }
      
  file { "/etc/ntp.conf":
    source  => "puppet:///modules/ntps/ntp.conf",
    recurse => true,
    require => [ Package['ntp','ntpdate']],
    notify  => Service['ntpd'],
  }

  file { "/etc/ntp/step-tickers":
    source  => "puppet:///modules/ntps/step-tickers",
    recurse => true,
    require => [ Package['ntp','ntpdate']],
    notify  => Service['ntpd'],
  }

 
  service { 'ntpd':
    ensure => running,
    enable => true,
  }

}