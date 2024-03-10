# 
# @summary The dnsmasq::cname defined type creates an entry in the dnsmasq configuration file for a CNAME record
# 
# @example # Create a cname record for host1.example.com that points to host2.example.com
#   dnsmasq::cname { 'host1.example.com':
#     hostname => 'host2.example.com',
#   }
# 
# @param name
#   The name of the CNAME record to create
# @param hostname
#   The hostname that the CNAME record should point to
#
define dnsmasq::cname (
  Stdlib::Fqdn $hostname,
) {
  include dnsmasq

  concat::fragment { "dnsmasq-cname-${name}":
    order   => '12',
    target  => 'dnsmasq.conf',
    content => template('dnsmasq/cname.erb'),
  }
}
