class golang () {

    $version = "1.5.1"
    $os_arch = "linux-amd64"
    $golang_tar_file = "go${version}.${os_arch}.tar.gz"
    $download_uri = "https://storage.googleapis.com/golang/${golang_tar_file}"
    $download_location = "/vagrant/puppet/modules/golang/files/${golang_tar_file}"

    package { 'curl': }

    exec { "download golang archive":
        command     => "curl ${download_uri} -o ${download_location}",
        creates     => $download_location,
        require     => Package["curl"],
        loglevel    => info,
        path        => "/usr/bin",
        timeout     => 120,
    }

    exec { 'unzip golang archive':
        command     => "tar -C /usr/local -xzf ${download_location}",
        path        => "/bin:/user/local",
        refreshonly => true,
        loglevel    => info,
        timeout     => 60,
    }

    file { '/etc/profile.d/golang.sh':
        content     => template('golang/golang.sh.erb'),
        ensure      => file,
        owner       => root,
        mode        => '0644',
    }

    Exec['download golang archive'] ~> Exec['unzip golang archive'] ~> File['/etc/profile.d/golang.sh']

}
