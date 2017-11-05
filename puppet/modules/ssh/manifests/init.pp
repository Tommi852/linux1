class ssh {
	package {'ssh':
	ensure => 'installed',
	allowcdrom => 'true',

	}
}
