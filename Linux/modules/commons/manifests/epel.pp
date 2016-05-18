class epel {
	
	# instalar epel
	package {"epel-release":
	  ensure => present,
	  source => "http://dl.fedoraproject.org/pub/epel/epel-release-latest-$lsbmajdistrelease.noarch.rpm",
	  provider => rpm,
	}
}