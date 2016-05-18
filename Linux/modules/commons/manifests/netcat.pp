class netcat {
	# instalar netcat
	package { "nc":
	  ensure => installed,
    require => Class['epel'],
	}
}