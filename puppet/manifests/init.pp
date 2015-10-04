Package {
    allow_virtual => true,
}

include git
include epel

service { 'iptables':
    enable => false,
    ensure => 'stopped'
}
