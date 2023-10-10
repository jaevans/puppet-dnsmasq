# Configure the DNS server to query sub domains to external DNS servers
# (--server).
define dnsmasq::dnsserver (
  Stdlib::IP::Address::Nosubnet $ip,
  Optional[Stdlib::FQDN] $domain = undef,
  Optional[Stdlib::Port] $port = undef,
) {
  $domain_real = $domain ? {
    undef   => '',
    default => "/${domain}/",
  }

  $port_real = $port ? {
    undef   => '',
    default => "#${port}",
  }

  include dnsmasq

  concat::fragment { "dnsmasq-dnsserver-${name}":
    order   => '13',
    target  => 'dnsmasq.conf',
    content => template('dnsmasq/dnsserver.erb'),
  }
}
