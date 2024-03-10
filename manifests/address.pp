# @summary Create a dnsmasq A record (--address).
#
# @example Create a dnsmasq A record
#   dnsmasq::address { 'myhost':
#     ip => '192.168.1.100'
#   }
#
# @param ip
#   The IP address to assign to the hostname.
#
# @see hostrecord for a more flexible way to create host records.
define dnsmasq::address (
  Stdlib::IP::Address::Nosubnet $ip,
) {
  if length($name) > 255 {
    fail('dnsmasq::address: hostname cannot be longer than 255 characters')
  }

  include dnsmasq

  concat::fragment { "dnsmasq-staticdns-${name}":
    order   => "07_${name}",
    target  => 'dnsmasq.conf',
    content => template('dnsmasq/address.erb'),
  }
}
