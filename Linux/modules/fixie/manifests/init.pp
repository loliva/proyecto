class fixie {
#Aplicaciones comunes para servidores
 
#Corrige problema de UTF-8
file { '/etc/sysconfig/i18n': owner => root, group => root, mode => '0644', source => 'puppet:///modules/commons/i18n', }

#Clase rsyslog para todas las maquinas
class {'rsyslog': }

#Clase baja servicios por defecto
class {'disable_service': }

#disable ipv6 
include sysctl
 sysctl::conf {"net.ipv6.conf.all.disable_ipv6": value => 1;}

#Incluye NO_IPV6
include stdlib
file_line { 'network_ipv6':
  path => '/etc/sysconfig/network',
  line => 'NETWORKING_IPV6=no',
}

#Elimina openjdk base
exec {'elimina_openjdk':
    command => "/usr/bin/yum remove -y java-1.7.0-openjdk java-1.6.0-openjdk java-1.8.0-openjdk; /bin/touch /etc/removeOldjdk",
    timeout => 0,
    creates => "/etc/removeOldjdk"
    }

#Baja selinux
exec {'disable_selinux':
    command => "/usr/sbin/setenforce 0; /bin/touch /etc/selinuxApplied",
    timeout => 0,
    creates => "/etc/selinuxApplied",
}


#Clase ntps para config horaria
class { 'ntps': }


}
