class mysql-client {
        package { 'mysql-client':
        ensure => 'installed',
        allowcdrom => true,
        }

        service { 'mysql-client':
                ensure  => true,
                enable  => true,
                }


}



