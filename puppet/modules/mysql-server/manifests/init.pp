class mysql-server {
	package { 'mysql-server':
	ensure => 'installed',
	allowcdrom => true,
	}

	service { 'mysql-server':
		ensure  => true,
		enable  => true,
		}


}

