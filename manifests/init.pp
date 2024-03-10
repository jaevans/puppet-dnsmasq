# @summary Manage dnsmasq
#
# @example
#   class { 'dnsmasq':
#     interface         => 'lo',
#     listen_address    => '192.168.39.1',
#     no_dhcp_interface => '192.168.49.1',
#     domain            => 'int.lan',
#     port              => '53',
#     expand_hosts      => true,
#     enable_tftp       => true,
#     tftp_root         => '/var/lib/tftpboot',
#     dhcp_boot         => 'pxelinux.0',
#     dns_forward_max   => 1500,
#     domain_needed     => true,
#     bogus_priv        => true,
#     no_negcache       => true,
#     no_hosts          => true,
#     resolv_file       => '/etc/resolv.conf',
#     cache_size        => 1000,
#     restart           => true,
#   }
#
# @see http://www.thekelleys.org.uk/dnsmasq/docs/dnsmasq-man.html
# 
# @param dnsmasq_confdir
#   Read all the files in the given directory as configuration files.
# @param dnsmasq_conffile
#   The location of the dnsmasq configuration file.
# @param dnsmasq_hasstatus
#   Whether the init script has status support.
# @param dnsmasq_logdir
#   The location of the dnsmasq log directory.
# @param dnsmasq_package
#   The name of the dnsmasq package.
# @param dnsmasq_service
#   The name of the dnsmasq service.
# @param dnsmasq_package_provider
#   Override the package provider for dnsmasq.
# @param auth_sec_servers
#  Specify any secondary servers for a zone for which dnsmasq is authoritative.
# @param auth_server
#   Enable authoritative DNS for queries on the specified interface or address.
# @param auth_ttl
#   Specify the TTL for DNS records served from the authoritative DNS server.
# @param auth_zone
#   Define a DNS zone for which dnsmasq acts as authoritative server.
# @param bogus_priv
#   Reject DNS responses which contain private IP addresses.
# @param cache_size
#   Set the size of dnsmasq's cache.
# @param config_hash
#   A hash of additional configuration options. This can be used to specify any additional
#   dnsmasq configuration that is not provided by the class's parameters. 
#   The hash keys are the dnsmasq configuration option names, and the hash values are the configuration to use
#   for that option. For example:
#   ```
#   class { 'dnsmasq':
#     config_hash => {
#       'dhcp-fqdn'          => true,
#        'dhcp-authoritative' => true,
#     },
#   }
#   ```
# @param dhcp_boot
#   Set the boot filename for netboot clients.
# @param dhcp_leasefile
#   Specify the location of the DHCP lease file.
# @param dhcp_no_override
#   Disable re-use of the DHCP servername and filename fields as extra option space.
# @param domain
#   Specify the domain name to be given to DHCP clients.
# @param domain_needed
#   Tell dnsmasq to never forward plain names (without a domain) to upstream nameservers.
# @param dns_forward_max
#   Set the maximum number of concurrent DNS queries.
# @param enable_tftp
#   Enable the built-in TFTP server.
# @param expand_hosts
#   Add the domain to plain names.
# @param interface
#   Specify the interface dnsmasq should listen on.
# @param listen_address
#   Specify the address dnsmasq should listen on. Both `listen_address` and `interface` can be specified.
# @param local_ttl
#   Set the TTL for DNS records served from /etc/hosts or the DHCP lease file. This should normally be set to 0.
# @param max_ttl
#   Set the maximum TTL for DNS records served to clients. If the true TTL is greater than the `max_ttl`, then
#   the TTL is reduced to the `max_ttl`.
# @param max_cache_ttl
#   Set the maximum TTL for records in the cache.
# @param neg_ttl
#   Set the TTL for negative responses from upstream servers that do not provide a TTL from the SOA.
# @param no_dhcp_interface
#   Specify an interface that should not be used for DHCP or TFTP, only DNS.
# @param no_hosts
#   Disable reading of /etc/hosts.
# @param no_negcache
#   Disable caching of negative responses.
# @param no_resolv
#   Disable reading of /etc/resolv.conf.
# @param port
#  Specify the port dnsmasq should listen on.
# @param read_ethers
#   Read the Ethernet address from /etc/ethers and use it to set the DHCP provided hostname or IP address.
# @param reload_resolvconf
#   Use resolvconf(8) to notify clients of changes to /etc/resolv.conf.
# @param resolv_file
#   Read the IP addresses of the upstream nameservers from this file, instead of /etc/resolv.conf.
# @param restart
#   Whether to restart the dnsmasq service when the configuration changes.
# @param run_as_user
#   Specify the user to run dnsmasq as.
# @param save_config_file
#   Whether to save the commented default config file after installation.
# @param service_enable
#   Whether the dnsmasq service should be enabled.
# @param service_ensure
#   Whether the dnsmasq service should be running or stopped.
# @param strict_order
#   Require DNS servers to be queried in the order specified by the `resolv_file`.
# @param manage_tftp_root
#   Whether to manage the TFTP root directory.
# @param tftp_root
#   Specify the root directory for files available via TFTP.
class dnsmasq (
  Stdlib::Absolutepath $dnsmasq_confdir,
  Stdlib::Absolutepath $dnsmasq_conffile,
  Boolean $dnsmasq_hasstatus,
  Stdlib::Absolutepath $dnsmasq_logdir,
  String[1] $dnsmasq_package,
  String[1] $dnsmasq_service,
  Optional[String[1]] $dnsmasq_package_provider = undef,

  Optional[Array[String[1]]] $auth_sec_servers         = undef,
  Optional[String[1]] $auth_server              = undef,
  Optional[Integer] $auth_ttl                 = undef,
  Optional[String[1]] $auth_zone                = undef,
  Boolean $bogus_priv               = true,
  Integer $cache_size               = 1000,
  Hash $config_hash              = {},
  Optional[String[1]] $dhcp_boot                = undef,
  Optional[Stdlib::Absolutepath] $dhcp_leasefile           = undef,
  Boolean $dhcp_no_override         = false,
  Optional[Stdlib::Fqdn] $domain                   = undef,
  Boolean $domain_needed            = true,
  Optional[Integer] $dns_forward_max          = undef,
  Boolean $enable_tftp              = false,
  Boolean $expand_hosts             = true,
  Optional[String[1]] $interface                = undef,
  Optional[Stdlib::IP::Address::V4] $listen_address           = undef,
  Optional[Integer] $local_ttl                = undef,
  Boolean $manage_tftp_root         = false,
  Optional[Integer] $max_ttl                  = undef,
  Optional[Integer] $max_cache_ttl            = undef,
  Optional[Integer] $neg_ttl                  = undef,
  Optional[Stdlib::IP::Address::V4::Nosubnet] $no_dhcp_interface        = undef,
  Boolean $no_hosts                 = false,
  Boolean $no_negcache              = false,
  Boolean  $no_resolv                = false,
  Variant[Stdlib::Port,String[1]] $port                     = '53',
  Boolean $read_ethers              = false,
  Boolean $reload_resolvconf        = true,
  Optional[Stdlib::Absolutepath] $resolv_file              = undef,
  Boolean  $restart                  = true,
  Optional[String[1]] $run_as_user              = undef,
  Boolean $save_config_file         = true,
  Boolean $service_enable           = true,
  Stdlib::Ensure::Service $service_ensure           = 'running',
  Boolean $strict_order             = true,
  String[1] $tftp_root                = '/var/lib/tftpboot',
) {
  ## VALIDATION

  # validate_hash($config_hash)
  # validate_re($service_ensure,'^(running|stopped)$')
  # if undef != $auth_ttl { validate_re($auth_ttl,'^[0-9]+') }
  # if undef != $local_ttl { validate_re($local_ttl,'^[0-9]+') }
  # if undef != $neg_ttl { validate_re($neg_ttl,'^[0-9]+') }
  # if undef != $max_ttl { validate_re($max_ttl,'^[0-9]+') }
  # if undef != $max_cache_ttl { validate_re($max_cache_ttl,'^[0-9]+') }
  if undef != $listen_address and !is_ip_address($listen_address) {
    fail("Expect IP address for listen_address, got ${listen_address}")
  }

  ## CLASS VARIABLES

  # Allow custom ::provider fact to override our provider, but only
  # if it is undef.
  # $provider_real = $::provider

  # if defined('$provider_real') {
  #   $provider_real = $dnsmasq_package_provider ? {
  #     undef   => $provider_real,
  #     default => $dnsmasq_package_provider,
  #   }
  # } else {
  #   $provider_real = $dnsmasq_package_provider
  # }

  ## MANAGED RESOURCES

  concat { 'dnsmasq.conf':
    path    => $dnsmasq_conffile,
    warn    => true,
    require => Package['dnsmasq'],
  }

  concat::fragment { 'dnsmasq-header':
    order   => '00',
    target  => 'dnsmasq.conf',
    content => template('dnsmasq/dnsmasq.conf.erb'),
  }

  package { 'dnsmasq':
    ensure => installed,
    name   => $dnsmasq_package,
    # provider => $provider_real,
    before => Service['dnsmasq'],
  }

  service { 'dnsmasq':
    ensure    => $service_ensure,
    name      => $dnsmasq_service,
    enable    => $service_enable,
    hasstatus => $dnsmasq_hasstatus,
  }

  if $restart {
    Concat['dnsmasq.conf'] ~> Service['dnsmasq']
  }

  if $dnsmasq_confdir {
    file { $dnsmasq_confdir:
      ensure => 'directory',
      owner  => 0,
      group  => 0,
      mode   => '0755',
    }
  }

  if $save_config_file {
    # let's save the commented default config file after installation.
    exec { 'save_config_file':
      command => "cp ${dnsmasq_conffile} ${dnsmasq_conffile}.orig",
      creates => "${dnsmasq_conffile}.orig",
      path    => ['/usr/bin', '/usr/sbin', '/bin', '/sbin',],
      require => Package['dnsmasq'],
      before  => Concat['dnsmasq.conf'],
    }
  }

  if $reload_resolvconf {
    exec { 'reload_resolvconf':
      provider => shell,
      command  => '/sbin/resolvconf -u',
      path     => ['/usr/bin', '/usr/sbin', '/bin', '/sbin',],
      user     => root,
      onlyif   => 'test -f /sbin/resolvconf',
      before   => Service['dnsmasq'],
      require  => Package['dnsmasq'],
    }
  }

  if $manage_tftp_root {
    file { $tftp_root:
      ensure => directory,
      owner  => 0,
      group  => 0,
      mode   => '0644',
      before => Service['dnsmasq'],
    }
  }

  if ! $no_hosts {
    Host <||> {
      notify +> Service['dnsmasq'],
    }
  }
}
