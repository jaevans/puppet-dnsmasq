# Create an dnsmasq ptr record (--ptr-record).
define dnsmasq::ptr (
  String[1] $value,
) {
  include dnsmasq

  concat::fragment { "dnsmasq-ptr-${name}":
    order   => '10',
    target  => 'dnsmasq.conf',
    content => template('dnsmasq/ptr.erb'),
  }
}
