# Create an dnsmasq dhcp option (--dhcp-option).
define dnsmasq::dhcpoption (
  String[1] $content,
  String[1] $option = $title,
  Optional[String[1]] $tag = undef,
) {
  $tag_real = $tag ? {
    undef   => '',
    default => "tag:${tag},",
  }

  $option_real = $option =~ /^option:/ ? {
    true => $option,
    default => "option:${option}",
  }

  include dnsmasq

  concat::fragment { "dnsmasq-dhcpoption-${name}":
    order   => '03',
    target  => 'dnsmasq.conf',
    content => template('dnsmasq/dhcpoption.erb'),
  }
}
