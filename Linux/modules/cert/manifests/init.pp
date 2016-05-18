class cert {
   
   $base='/etc/pki/tls'
   $base_key='private'
   $base_cert='certs'
   $base_name='logstash-forwarder'
   $logstash_server='192.168.123.2'
   
   #copia openssl.conf
   file { "${base}/openssl.conf":
   owner => root,
   group => root,
   mode => '0644',
   content => template('cert/openssl.conf.erb'),
  }
   #genera cert
   exec {'genera_cert':
    command => "/usr/bin/openssl req -x509 -batch -nodes -newkey rsa:2048 -keyout ${base}/${base_key}/${base_name}.key -out ${base}/${base_cert}/${base_name}.crt -subj /CN=kibana.local",
    timeout => 7200,
    }
  }    