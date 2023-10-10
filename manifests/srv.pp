# Create an dnsmasq srv record (--srv-host).
define dnsmasq::srv (
  Stdlib::Host $hostname,
  Stdlib::Port $port,
  Optional[Variant[String, Integer]] $priority = undef,
) {
  $priority_real = $priority ? {
    undef   => '',
    default => ",${priority}",
  }

  include dnsmasq

  concat::fragment { "dnsmasq-srv-${name}":
    order   => '09',
    target  => 'dnsmasq.conf',
    content => template('dnsmasq/srv.erb'),
  }
}
