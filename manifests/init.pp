class acmetool {
	unless ($osfamily == 'Debian') { fail('This module is unfortunately only implemented for Debian. Pull requests welcome!') }

	apt::source { 'ppa_hlandau':
		location => 'http://ppa.launchpad.net/hlandau/rhea/ubuntu',
		release  => 'xenial',
		repos    => 'main',
		key      => {
			id      => '9862409EF124EC763B84972FF5AC9651EDB58DFA',
			server  => 'keyserver.ubuntu.com',
		},
		include  => {
			'src' => false,
			'deb' => true,
		},
	}
	package {'acmetool': ensure => installed }
	cron {'acmetool':
		command => '/usr/bin/acmetool --batch',
		user => 'root',
		hour => '2',
		minute => '17',
		weekday => 'Mon',
	}
}
