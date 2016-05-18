class sysctl {
   file { "sysctl_conf":
      name => $operatingsystem ? {
        default => "/etc/sysctl.conf",
      },
   }

   exec { "/sbin/sysctl -e -p":
      alias       => "sysctl",
      refreshonly => true,
      subscribe   => File["sysctl_conf"],
   }
}