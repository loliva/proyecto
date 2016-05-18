class telnet {
	# instalar telnet
	package { "telnet":
	  ensure => installed,
    require => Class['epel'],
	}
}