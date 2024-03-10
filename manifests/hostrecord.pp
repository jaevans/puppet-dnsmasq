# @summary Create a dnsmasq A,AAAA and PTR record (--host-record).
#
# @param ip
#   The IPv4 address or an array of IPv4 addresses for the host record. 
#   Each IP address should be a string in the format of 'x.x.x.x', where each x is a number from 0 to 255.
#
# @param ipv6
#   The optional IPv6 address for the host record. 
#   The IP address should be a string in the format of 'x:x:x:x:x:x:x:x', where each x is a hexadecimal number from 0 to FFFF.
#
# @example Create a host record with a single IPv4 address
#   dnsmasq::hostrecord { 'example':
#     ip => '192.168.0.1',
#   }
#
# @example Create a host record with multiple IPv4 addresses
#   dnsmasq::hostrecord { 'example':
#     ip => ['192.168.0.1', '192.168.0.2'],
#   }
#
# @example Create a host record with an IPv4 and an IPv6 address
#   dnsmasq::hostrecord { 'example':
#     ip => '192.168.0.1',
#     ipv6 => '2001:0db8:85a3:0000:0000:8a2e:0370:7334',
#   }
define dnsmasq::hostrecord (
  Variant[Stdlib::IP::Address::V4::Nosubnet, Array[Stdlib::IP::Address::V4::Nosubnet]] $ip,
  Optional[Stdlib::IP::Address::V6::Nosubnet] $ipv6 = undef,
) {
  # if !is_ip_address($ip) { fail("Expect IP address for ip, got ${ip}") }

  include dnsmasq

  $ipv6_real = $ipv6 ? {
    undef   => '',
    default => ",${ipv6}",
  }
  concat::fragment { "dnsmasq-hostrecord-${title}":
    order   => '07',
    target  => 'dnsmasq.conf',
    content => epp('dnsmasq/hostrecord.epp', { 'name' => $name, 'ip' => $ip, 'ipv6_real' => $ipv6_real }),
  }
}
