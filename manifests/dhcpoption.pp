# @summary Configure DHCP options for dnsmasq
#
# This definition allows for the creation and management of dnsmasq DHCP options,
# providing a way to specify options with or without tags, and handling numeric
# and named options appropriately.
#
# @param content The content of the DHCP option to be set.
# @param option The name of the DHCP option.
# If not explicitly provided, it defaults to the resource's title.
# Numeric options and those starting with 'option:' are handled specifically.
# @param tag An optional tag to associate with the DHCP option. If not provided, no tag is applied.
#
# @example Create a DHCP option with a tag
#   dnsmasq::dhcpoption { 'example-option':
#     content => 'example-content',
#     option  => 'example-option-name',
#     tag     => 'example-tag',
#   }
#
# @see dnsmasq The main dnsmasq class that must be included before using this resource type.
# @see concat::fragment
# The concat::fragment resource type used for managing parts of the dnsmasq configuration file.
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

  concat::fragment { "dnsmasq-dhcpoption-${tag}-${option}":
    order   => '03',
    target  => 'dnsmasq.conf',
    content => epp('dnsmasq/dhcpoption.epp', {
        tag_real    => $tag_real,
        option_real => $option_real,
        content     => $content,
    }),
  }
}
