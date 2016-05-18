define mongo::repl ( 
	$data_name = "data", 
	$data_port = "27000",
	$data_base = "/gps/mongo", 
) {
	if ! defined(Exec["create_${data_base}"]) {
		exec { "create_${data_base}":
			command => "/bin/mkdir -p ${data_base}",
			creates => "${data_base}",
		}
	}
	if ! defined(File["${data_base}"]) {
		file { "${data_base}":
			ensure => "directory",
			require => Exec["create_${data_base}"],
		}
	}
	
	file { "${data_base}/${data_name}":
		ensure => "directory",
		require => File["${data_base}"],
	}
	
	file { "/etc/monit.d/mongo-${data_name}":
		content => template('mongo/monit-repl.erb'),
		notify  => Service['monit'],
		require => [ Class['mongo'], Package['monit'], File["${data_base}/${data_name}"] ],
	}
}