class { 'bind':
    
    forwarders => [
        '8.8.8.8',
        '8.8.4.4',
    ],
    dnssec     => true,
}

bind::zone { 'example.com-external':
    zone_type       => 'master',
    domain          => 'example.com',
    allow_updates   => [ 'key local-update', ],
    allow_transfers => [ 'secondary-dns', ],
    ns_notify       => true,
    dnssec          => true,
    key_directory   => '/var/cache/bind/example.com',
}


