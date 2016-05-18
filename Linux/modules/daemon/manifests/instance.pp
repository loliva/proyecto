define daemon::instance (
	$group_id = "cl/tastets/life",
	$maven_host = "maven.gps.cl:8080",
	$maven_user = "server",
	$maven_pass = "server1",
	$suffix = "",
	$artifact_id = $name,
	$version,
	$port,
	$force = "no",
	$jvm_params = "",
	$daemon_params = "",
	$java_path = "",
	$tslocal = "LOCAL2",
) {
	
	$daemon_env = $daemon::daemon_env
	$daemon_node = $daemon::daemon_node
	$daemon_common_params = $daemon::daemon_common_params
	$daemon_time = $daemon::daemon_time
	$daemon_cycles = $daemon::daemon_cycles
	$daemon_base = $daemon::daemon_base
	$daemon_bin = $daemon::daemon_bin
	$daemon_log = $daemon::daemon_log
	$daemon_run = $daemon::daemon_run
	$daemon_jar = $daemon::daemon_jar


	$download_url = "http://${maven_user}:${maven_pass}@${maven_host}/archiva/repository/tastets/${group_id}/${artifact_id}/${version}/${artifact_id}-${version}${suffix}.jar"
	$download_jar = "${daemon_jar}/${artifact_id}-${version}${suffix}.jar"
	$download_tmp = "/tmp/${name}.jar"
	$daemon_link = "${daemon_jar}/${name}.jar"
	$daemon_name = $name
	$daemon_version = $version
	$daemon_local = $tslocal

	# descargar de maven si no existe
	exec { "download_${download_tmp}":
      command => "/usr/bin/curl -s -f -o ${download_jar} '${download_url}'",
      timeout => "0",
      creates => $download_jar,
      require => Class["daemon"],
      notify => File[$daemon_link],
	}
	
	file { $daemon_link:
		ensure => 'link',
		target => $download_jar,
		replace => "yes",
		notify => Exec["restart_${name}"],
	}
	
	# crear archivo de init
	file { "${daemon_bin}/${name}.sh":
		mode => '0755',
		content => template('daemon/daemon.sh.erb'),
		notify => Exec["restart_${name}"],
		require => Package['monit'],
		#require => [ File[$daemon_link] ],
	}
	
	# crear archivo monit
	file { "/etc/monit.d/daemon-${name}":
		content => template('daemon/daemon.monit.erb'),
		notify  => Service['monit'],
		require => Package['monit'],
	}
	
	exec { "restart_${name}":
	  command => "/usr/bin/monit restart ${name}",
	  refreshonly => true,
	}
	
}