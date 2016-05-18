define mongo::shard ( 
	$data_name = "shard", 
	$data_port = "27117",
	$data_config = "localhost:27017", 
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
	
	file { "/etc/monit.d/mongo-${data_name}":
		content => template('mongo/monit-shard.erb'),
		notify  => Service['monit'],
		require => [ Class['mongo'], Package['monit'], File["${data_base}"] ],
	}
}