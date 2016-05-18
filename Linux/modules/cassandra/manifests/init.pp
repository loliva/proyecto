class cassandra( 
	$cluster_name = "test",
	$seeds = "127.0.0.1", 
	$dc = "TEST",
	$rack = "RACK",
	$listen_ip = "127.0.0.1",
	$rpc_ip = $listen_ip,
) {

	exec { 'swapoff':
	  command => '/sbin/swapoff -a; /bin/sed -i.bak "/ swap / s/^\(.*\)$/#\1/g" /etc/fstab; /bin/echo "disabled" > /etc/swap',
	  creates => '/etc/swap',
	} -> 
	file { '/etc/yum.repos.d/datastax.repo':
        owner => root,
        group => root,
        mode => '0644',
        source => 'puppet:///modules/cassandra/datastax.repo',
        require => Class['java8'],
    }
    
    package { ['jemalloc', 'datastax-ddc'] :
    	ensure => installed,
    	require => File['/etc/yum.repos.d/datastax.repo'],
    }
    
	file { '/etc/cassandra/conf/jvm.options':
        owner => root,
        group => root,
        mode => '0644',
        source => 'puppet:///modules/cassandra/jvm.options',
    	require => Package['datastax-ddc'],
    	notify => Service['cassandra'],
    }

	file { '/etc/cassandra/conf/cassandra-env.sh':
        owner => root,
        group => root,
        mode => '0644',
        source => 'puppet:///modules/cassandra/cassandra-env.sh',
    	require => Package['datastax-ddc'],
    	notify => Service['cassandra'],
    }

	file { '/etc/cassandra/conf/cassandra.yaml':
        owner => root,
        group => root,
        mode => '0644',
        content => template('cassandra/cassandra.yaml.erb'),
    	require => Package['datastax-ddc'],
    	notify => Service['cassandra'],
    }

	file { '/etc/cassandra/conf/cassandra-rackdc.properties':
        owner => root,
        group => root,
        mode => '0644',
        content => template('cassandra/cassandra-rackdc.properties.erb'),
    	require => Package['datastax-ddc'],
    	notify => Service['cassandra'],
    }
    
    service { 'cassandra':
    	ensure => running,
    	enable => true,
    	require => Package['datastax-ddc'],
    }

}