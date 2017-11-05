class apache2 {
	package {'apache2':
	ensure => 'installed',
	allowcdrom => 'true',

	}	

        service {'apache2':
               ensure => 'running',
               enable => 'true',
               require => Package['apache2'],
	}


	file { '/etc/apache2/mods-enabled/userdir.conf':
		ensure => 'link',
		target => '../etc/apache2/mods-enabled/userdir.conf',
		require => Package['apache2'],
	}

        file { '/etc/apache2/mods-enabled/userdir.load':
                ensure => 'link',
                target => '../etc/apache2/mods-enabled/userdir.load',
                require => Package['apache2'],
	}


	file { '/var/www/html/index.html':
		content => 'Hello',
		owner => '0',
		group => '0',
		mode => '0644',
	}
}
