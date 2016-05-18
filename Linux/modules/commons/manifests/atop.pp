class atop {
	# instalar atop
	package { "atop":
	  ensure => installed,
    require => Class['epel'],
	}
}