# Primary class with options.  See documentation at
# http://www.thekelleys.org.uk/dnsmasq/docs/dnsmasq-man.html
class dnsmasq (
  $dnsmasq_confdir,
  $dnsmasq_conffile        ,
  $dnsmasq_hasstatus       ,
  $dnsmasq_logdir          ,
  $dnsmasq_package         ,
  $dnsmasq_package_provider = undef,
  $dnsmasq_service         ,
  $auth_sec_servers         = undef,
  $auth_server              = undef,
  $auth_ttl                 = undef,
  $auth_zone                = undef,
  $bogus_priv               = true,
  $cache_size               = 1000,
  $config_hash              = {},
  $dhcp_boot                = undef,
  $dhcp_leasefile           = undef,
  $dhcp_no_override         = false,
  $domain                   = undef,
  $domain_needed            = true,
  $dns_forward_max          = undef,
  $enable_tftp              = false,
  $expand_hosts             = true,
  $interface                = undef,
  $listen_address           = undef,
  $local_ttl                = undef,
  $manage_tftp_root         = false,
  $max_ttl                  = undef,
  $max_cache_ttl            = undef,
  $neg_ttl                  = undef,
  $no_dhcp_interface        = undef,
  $no_hosts                 = false,
  $no_negcache              = false,
  $no_resolv                = false,
  $port                     = '53',
  $read_ethers              = false,
  $reload_resolvconf        = true,
  $resolv_file              = false,
  $restart                  = true,
  $run_as_user              = undef,
  $save_config_file         = true,
  $service_enable           = true,
  $service_ensure           = 'running',
  $strict_order             = true,
  $tftp_root                = '/var/lib/tftpboot',
  # $auth_sec_servers         = undef,
  # $auth_server              = undef,
  # Integer $auth_ttl                 = undef,
  # $auth_zone                = undef,
  # Boolean $bogus_priv               = true,
  # Integer $cache_size               = 1000,
  # Hash $config_hash              = {},
  # $dhcp_boot                = undef,
  # $dhcp_leasefile           = undef,
  # Boolean $dhcp_no_override         = false,
  # Optional[Stdlib::Fqdn] $domain                   = undef,
  # Boolean $domain_needed            = true,
  # $dns_forward_max          = undef,
  # Stdlib::Absolutepath $dnsmasq_confdir          = $dnsmasq::params::dnsmasq_confdir,
  # Stdlib::Absolutepath $dnsmasq_conffile         = $dnsmasq::params::dnsmasq_conffile,
  # Boolean $dnsmasq_hasstatus        = $dnsmasq::params::dnsmasq_hasstatus,
  # Stdlib::Absolutepath $dnsmasq_logdir           = $dnsmasq::params::dnsmasq_logdir,
  # $dnsmasq_package          = $dnsmasq::params::dnsmasq_package,
  # $dnsmasq_package_provider = $dnsmasq::params::dnsmasq_package_provider,
  # $dnsmasq_service          = $dnsmasq::params::dnsmasq_service,
  # Boolean $enable_tftp              = false,
  # Boolean $expand_hosts             = true,
  # Optional[String[1]] $interface                = undef,
  # Optional[Stdlib::IP::Address::V4] $listen_address           = undef,
  # Integer $local_ttl                = undef,
  # Boolean $manage_tftp_root         = false,
  # Integer $max_ttl                  = undef,
  # Integer $max_cache_ttl            = undef,
  # Integer $neg_ttl                  = undef,
  # $no_dhcp_interface        = undef,
  # Boolean $no_hosts                 = false,
  # Boolean $no_negcache              = false,
  # Boolean  $no_resolv                = false,
  # Stdlib::Port $port                     = '53',
  # Boolean $read_ethers              = false,
  # Boolean $reload_resolvconf        = true,
  # Boolean $resolv_file              = false,
  # Boolean  $restart                  = true,
  # Optional[String[1]] $run_as_user              = undef,
  # Boolean $save_config_file         = true,
  # Boolean $service_enable           = true,
  # Stdlib::Ensure::Service $service_ensure           = 'running',
  # Boolean $strict_order             = true,
  # Optional[String[1]] $tftp_root                = '/var/lib/tftpboot',
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
