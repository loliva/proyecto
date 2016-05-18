# agrupa varias instalaciones comunes
class commons($tsenv = "QA") {
	class { 'epel': }
	class { 'dstat': }
	class { 'monit': tsenv => $tsenv }
	class { 'atop': }
  class { 'lsof': }	
	class { 'nload': }
	class { 'nmap': }
	class { 'nmon': }
	class { 'screen': }
	class { 'telnet': }
	class { 'netcat': }
	class { 'wget': }
	class { 'ccze': }
	class { 'nano': }	
}

