class mongo {

	file { '/etc/init.d/disable-transparent-hugepages':
        owner => root,
        group => root,
        mode => '0755',
        source => 'puppet:///modules/mongo/disable-transparent-hugepages',
	} ->
    service { 'disable-transparent-hugepages':
    	ensure => "running",
    	enable => true,
    }

	file { '/etc/yum.repos.d/mongodb-org-3.0.repo':
        owner => root,
        group => root,
        mode => '0644',
        source => 'puppet:///modules/mongo/mongodb-org-3.0.repo',
    }
    
    package { 'mongodb-org' :
    	ensure => installed,
    	require => File['/etc/yum.repos.d/mongodb-org-3.0.repo'],
    }
    
    service { 'mongod':
    	ensure => "stopped",
    	enable => false,
    	require => Package['mongodb-org'],
    }
}