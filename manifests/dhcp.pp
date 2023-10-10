# Create an dnsmasq stub zone for caching upstream name resolvers
# (--dhcp-range).
define dnsmasq::dhcp (
  Stdlib::IP::Address::V4::Nosubnet $dhcp_start,
  Stdlib::IP::Address::V4::Nosubnet $dhcp_end,
  Stdlib::IP::Address::V4::Nosubnet $netmask,
  String[1] $lease_time,
  Optional[String[1]] $tag = undef,
  Optional[String[1]] $set = undef,
  Optional[String[1]] $mode = undef,
) {
  $set_real = $set ? {
    undef   => '',
    default => "set:${set},",
  }
  $tag_real = $tag ? {
    undef   => '',
    default => "tag:${tag},",
  }
  $mode_real = $mode ? {
    undef => '',
    default => "${mode},"
  }

  include dnsmasq

  concat::fragment { "dnsmasq-dhcprange-${name}":
    order   => '01',
    target  => 'dnsmasq.conf',
    content => template('dnsmasq/dhcp.erb'),
  }
}
