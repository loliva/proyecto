
class java8 {
	exec{'download_java8':
		command => "/usr/bin/wget -q -O jdk-8u45-linux-x64.rpm --no-cookies --no-check-certificate --header 'Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie' 'http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.rpm' -O /usr/local/jdk-8u45-linux-x64.rpm",
		creates => "/usr/local/jdk-8u45-linux-x64.rpm",
		timeout => 7200,
		require => Class['wget']
	}
	
	file{'/usr/local/jdk-8u45-linux-x64.rpm':
		mode => '0644',
		require => Exec["download_java8"],
	}
	
	package {"jdk1.8.0_45":
		ensure => present,
		source => "/usr/local/jdk-8u45-linux-x64.rpm",
		provider => rpm,
		require => File['/usr/local/jdk-8u45-linux-x64.rpm']
	}
}
