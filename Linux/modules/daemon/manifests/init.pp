class daemon ( $tsenv, $tsnode, $tsparams = "", $tstime, $tscycles = "6") {
  $daemon_env = $tsenv
  $daemon_node = $tsnode
  $daemon_time = $tstime
  $daemon_cycles = $tscycles
  $daemon_common_params = $tsparams
	$daemon_base = "/gps/daemon"
	$daemon_bin = "${daemon_base}/bin"
	$daemon_log = "${daemon_base}/log"
	$daemon_run = "${daemon_base}/run"
	$daemon_jar = "${daemon_base}/jar"
	
	# crear carpetas por defecto
	exec { "create_${daemon_base}":
		command => "/bin/mkdir -p ${daemon_base}",
		creates => "${daemon_base}",
	}
	
	file { '/etc/log4j.properties':
		owner => root,
		group => root,
		mode => '0755',
		source => "puppet:///modules/daemon/log4j-${daemon_env}.properties",
    }
    
	file { '/etc/logback.xml':
		owner => root,
		group => root,
		mode => '0755',
		source => "puppet:///modules/daemon/logback-${daemon_env}.xml",
    }
    
	file { "$daemon_bin":
		ensure => "directory",
		require => Exec["create_${daemon_base}"],
	}
	
	file { "$daemon_log":
		ensure => "directory",
		require => Exec["create_${daemon_base}"],
	}
	
	file { "$daemon_run":
		ensure => "directory",
		require => Exec["create_${daemon_base}"],
	}
	
	file { "$daemon_jar":
		ensure => "directory",
		require => Exec["create_${daemon_base}"],
	}
	
}