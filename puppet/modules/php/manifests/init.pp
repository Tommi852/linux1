class php {
        package { 'php7.0':
        ensure => 'installed',
        allowcdrom => true,
        }

        service { 'php7.0':
                ensure  => true,
                enable  => true,
                }


}
