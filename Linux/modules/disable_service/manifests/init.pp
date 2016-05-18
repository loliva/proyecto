class disable_service {

  service { 'rpcbind':
    enable => false,
  }
  service { 'postfix':
    enable => false,
  }
  service { 'sendmail':
    enable => false,
  }
  service { 'cups':
    enable => false,
  }
  service { 'nfslock':
    enable => false,
  }
  service { 'iptables':
    enable => false,
  }
  service { 'ip6tables':
    enable => false,
  }
  service { 'rpcgssd':
    enable => false,
  }  
  service { 'rpcsvcgssd':
    enable => false,
  }  
  service { 'atd':
    enable => false,
  }  
  service { 'netfs':
    enable => false,
  }  
  service { 'saslauthd':
    enable => false,
  }
  service { 'portreserve':
    enable => false,
  }
  service { 'abrtd':
    enable => false,
  }
}


