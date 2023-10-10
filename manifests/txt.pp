# Create an dnsmasq txt record (--txt-record).
define dnsmasq::txt (
  $value,
) {
  include dnsmasq

  concat::fragment { "dnsmasq-txt-${name}":
    order   => '11',
    target  => 'dnsmasq.conf',
    content => template('dnsmasq/txt.erb'),
  }
}
