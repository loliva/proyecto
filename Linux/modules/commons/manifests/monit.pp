
class monit ($tsenv = "QA") {
	# instalar monit
	package { "monit":
	  ensure => installed,
	  require => Class['epel'],
	}
	
	file { '/etc/monit.d/monit-httpd':
        owner => root,
        group => root,
        mode => '0644',
        source => 'puppet:///modules/commons/monit-httpd',
        require => Package['monit'],
    }
  file { '/etc/monit.conf':
        owner => root,
        group => root,
        mode => '0700',
        source => 'puppet:///modules/commons/monit.conf',
        require => Package['monit'],
    }
  file { '/etc/slack.rb':
        owner => root,
        group => root,
        mode => '0755',
        source => "puppet:///modules/commons/slack-${tsenv}.rb",
        require => Package['monit'],
    }
    
	# iniciar monit
	service { "monit":
	  ensure    => running,
	  enable    => true,
	  require => File['/etc/monit.d/monit-httpd'],
	}
}
