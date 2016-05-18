class usuarios {

#Para generar una clave md5 para passwd procesar antes => echo "gps2016" | openssl passwd -stdin

#Genero grupo

group { 'oper': 
      ensure => absent,
}
->

group { 'operaciones': 
      gid => 2001, 
      ensure => present,
      allowdupe => true,
}

#Genero sudo

file { '/etc/sudoers.d/oper':
    source => 'puppet:///modules/account/oper.sudo',
    mode => '0644',
    owner => "root",
    require => Group ['operaciones'],
  }

#Genero usuarios
account { 'loliva':
  home_dir => '/home/loliva', 
  uid => 2099, 
  password => '9o6GlsOh7g44M', 
  groups => [ 'operaciones' ], 
  ssh_key => 'AAAAB3NzaC1kc3MAAACBAM6DEtBOSjrMzWGOAMLkhlYd36/y/LVdOWPPBaWa3HBl9F0gA4HjCVW/QH5COi7KUemiIWVSSXZzNhmAJ1RD5Kvl7JO2Pf7tswykl7sml5U5UbCAq4fk5jJvnwp6jD1i2ga4ilw+c/V6tvbeUvHfXTuah3UBFZKr3HZjU6767Bt3AAAAFQDqr6Iwd0Wx/gN/+kIyxNAmzvJG6QAAAIAv3KcSItP055Cr8zRB2MXrAw8bjsyeJbm/QDvv/QKXZ0/HF38xsvtt8d1dt1xuD/aRPZiZGcb2CtCmwRp2L84ik7lZyA0rPqlwbF3aO5H3TLsEnRWvYjpaJEkJWwW+Ex+WTJpF+vjWhHWp9HlfHOOGyXesL2/9W49QMjB11Ej7vQAAAIBlvL2SAe6BY2N9L9Dc9j1ivCOPR8Q60z8/x0l2l2nYe5Edg6IlUfofvq60GO8UXCFy2vNeLOT8kJMtnprxAJcTFms4OSH9a1riM1MaForqswytQJvkT1LQPYXGGDy+3TO23/TeL3z4/KXQEhN4zl5f22X3h2m5mzr1WQxXnFL75A==', 
  ssh_key_type => 'ssh-dss',
  ensure => present
  }

account { 'bgallegos':
  home_dir => '/home/bgallegos', 
  uid => 2100, 
  password => '9o6GlsOh7g44M', 
  groups => [ 'operaciones' ], 
  ensure => present
  }

account { 'desasis':
  home_dir => '/home/desasis',
  uid => 2101,
  password => 'PLfgTslODL73g',  
  ensure => present
  }

account { 'operador': 
  home_dir => '/home/operador', 
  uid => 2102,password => '9o6GlsOh7g44M', 
  groups => [ 'operaciones' ], 
  ensure => present 
  }

account { 'mvera':
  home_dir => '/home/mvera', 
  uid => 2103,
  password => '9o6GlsOh7g44M', 
  groups => [ 'operaciones' ], 
  ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDF1xeyz2Lsm3gV9WQ3PZ3KHhnFk3xm6YFVHG4O1PsPxrMtKkvYY1YwF4CuwFyYOdMIxgBlzQbBYSdFozF2T/oW4bMZT6P5PfoCSfbLY+ZBGrlD9U5LhTGP15USg/n44Hd4Qlyd1t1AFZn4lbalF4Y1UCKX8e5vXj07rH8R1gpNvxCOWEoGetGPMOVkaZC5YrDbuc1BirvC/yvl7kep+RRFkUqqi4U5U2lB7TXj/SOBEacbu3Vwd72En1YPf+dDlCE8l3FGJMt17veytBjMg5KnJ0JaU9Kyi25go7xKIrrUoBuwEZJf/URfKw5CNoGjMWxyfzenCxhWnEhgsr9e5fGl', 
  ssh_key_type => 'ssh-rsa', 
  ensure => present
  }

account { 'sparedes': 
  home_dir => '/home/sparedes', 
  uid => 2104,
  password => '9o6GlsOh7g44M', 
  groups => [ 'operaciones' ], 
  ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQCuZsqwENImoD1b5805UbDgmZCCYjyw2sVJLyc079iZnx4EqkHnJsDDsAVSkFFbxYacHUyfkqorNlz9o+9bjn73tR+KlvY1M2rXb8fa95xx210+Vw/1WLiG91nl9JBGD4p3YOAzm+e2/qNUfrc2HiX2soSOB7ZDLkSXHoA7U9iZ782IaVKkRKRF7r/jdNkFEjIZQFLGlmhX1CslF4C+uY1EbhlyOtXbZaFdk212K5LxmhylJaC7w4lz9dtEeRoYRLshEn7vG3fdLs2cDuMLfF1VehGdMTG6ViE3vqu6DbfJPTx4yJk3EH6XN+YGA3JB0Ts+AQobozZwLGr2YAmlFhq3eX8vYRZJFC+G7Hup6aTlWroczmeB+IWXyLgRbDFxm7jdOlkRd0jepQDt2a/rduhe6MXV2ugTjhAmfAdFMka1vP6Eg72ay/mOLz2MrVQVXBiKP1vIuG8ZOMW4FXy8wAix8Ssw5lIxAO0mP6vIcqdnDSGqsw812SX0vZis//EndrDKXUpE4ZIPUvaWIrQAOtadNo2wRv45ao4MZcVbYq9uRD+ftl55FQm8Ug1xyg6g9s1TcL+FX9DLLpLpQJ0cCOu3CmTV1j3DhdRd0j6Yb2gg5fZeBXyDENc5QpnF5aZYUIT4t9VlGubmMjw2hOyf1PVddBV9EGRHui5p+IxLkViIQw==', 
  ssh_key_type => 'ssh-rsa', 
  ensure => present 
  }
}