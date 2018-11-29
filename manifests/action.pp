define fail2ban::action (
  String             $upstream,
) {
  include fail2ban::config
  exec {
    'fetch_data':
    command => "/usr/bin/wget -q http://filehost.domain/${upstream}.local -O /etc/fail2ban/action.d/${upstream}.local ",
    creates => "/etc/fail2ban/action.d/${upstream}.local",
    unless  => "test -f /etc/fail2ban/action.d/${upstream}.local",
  }
  file { "/etc/fail2ban/filter.d/${upstream}":
    ensure  => 'present',
    owner   => 'root',
    group   => 0,
    mode    => '0644',
    require => [Class['fail2ban::config']],
    notify  => Class['fail2ban::service'],
  }

}
