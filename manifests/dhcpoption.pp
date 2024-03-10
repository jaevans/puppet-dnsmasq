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

  # Check if the option is an integer or a string.
  # Numeric options should not be prefixed with 'option:'
  case $option {
    /^[0-9]+$/, /^option:/: {
      $option_real = $option
    }
    default: {
      $option_real = "option:${option}"
    }
  }

  include dnsmasq

  concat::fragment { "dnsmasq-dhcpoption-${option_real}":
    order   => '03',
    target  => 'dnsmasq.conf',
    content => template('dnsmasq/dhcpoption.erb'),
  }
}
