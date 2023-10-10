# Create a dnsmasq domain (--domain).
define dnsmasq::domain (
  Optional[Stdlib::IP::Address] $subnet = undef,
  Boolean $local  = false,
) {
  include dnsmasq

  $local_real = $local ? {
    true  => ',local',
    false => '',
  }
  $subnet_real = $subnet ? {
    undef   => '',
    default => ",${subnet}",
  }

  concat::fragment { "dnsmasq-domain-${name}":
    order   => '06',
    target  => 'dnsmasq.conf',
    content => template('dnsmasq/domain.erb'),
  }
}
