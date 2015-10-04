Package {
    allow_virtual => true,
}

include git
include epel
include golang

service { 'iptables':
    enable => false,
    ensure => 'stopped'
}
