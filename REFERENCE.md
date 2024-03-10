# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

* [`dnsmasq`](#dnsmasq): Manage dnsmasq

### Defined types

* [`dnsmasq::address`](#dnsmasq--address): Create a dnsmasq A record (--address).
* [`dnsmasq::cname`](#dnsmasq--cname): The dnsmasq::cname defined type creates an entry in the dnsmasq configuration file for a CNAME record
* [`dnsmasq::dhcp`](#dnsmasq--dhcp)
* [`dnsmasq::dhcpboot`](#dnsmasq--dhcpboot): Create an dnsmasq dhcp boot (PXE) record for customizing network booting (--dhcp-boot).
* [`dnsmasq::dhcpmatch`](#dnsmasq--dhcpmatch): Create a dnsmasq dhcp match
* [`dnsmasq::dhcpoption`](#dnsmasq--dhcpoption): Configure DHCP options for dnsmasq
* [`dnsmasq::dhcpstatic`](#dnsmasq--dhcpstatic): Create an dnsmasq stub zone for caching upstream name resolvers (--dhcp-host).
* [`dnsmasq::dnsrevserver`](#dnsmasq--dnsrevserver): Configure the DNS server to query sub domains to external DNS servers (--rev-server).
* [`dnsmasq::dnsrr`](#dnsmasq--dnsrr): Create an dnsmasq dnsrr record (--dns-rr).
* [`dnsmasq::dnsserver`](#dnsmasq--dnsserver): Configure the DNS server to query sub domains to external DNS servers (--server).
* [`dnsmasq::domain`](#dnsmasq--domain): Create a dnsmasq domain (--domain).
* [`dnsmasq::hostrecord`](#dnsmasq--hostrecord): Create a dnsmasq A,AAAA and PTR record (--host-record).
* [`dnsmasq::mx`](#dnsmasq--mx): Create an dnsmasq mx record (--mx-host).
* [`dnsmasq::ptr`](#dnsmasq--ptr): Create an dnsmasq ptr record (--ptr-record).
* [`dnsmasq::srv`](#dnsmasq--srv): Create an dnsmasq srv record (--srv-host).
* [`dnsmasq::txt`](#dnsmasq--txt): Create an dnsmasq txt record (--txt-record).

## Classes

### <a name="dnsmasq"></a>`dnsmasq`

Manage dnsmasq

* **See also**
  * http://www.thekelleys.org.uk/dnsmasq/docs/dnsmasq-man.html

#### Examples

##### 

```puppet
class { 'dnsmasq':
  interface         => 'lo',
  listen_address    => '192.168.39.1',
  no_dhcp_interface => '192.168.49.1',
  domain            => 'int.lan',
  port              => '53',
  expand_hosts      => true,
  enable_tftp       => true,
  tftp_root         => '/var/lib/tftpboot',
  dhcp_boot         => 'pxelinux.0',
  dns_forward_max   => 1500,
  domain_needed     => true,
  bogus_priv        => true,
  no_negcache       => true,
  no_hosts          => true,
  resolv_file       => '/etc/resolv.conf',
  cache_size        => 1000,
  restart           => true,
}
```

#### Parameters

The following parameters are available in the `dnsmasq` class:

* [`dnsmasq_confdir`](#-dnsmasq--dnsmasq_confdir)
* [`dnsmasq_conffile`](#-dnsmasq--dnsmasq_conffile)
* [`dnsmasq_hasstatus`](#-dnsmasq--dnsmasq_hasstatus)
* [`dnsmasq_logdir`](#-dnsmasq--dnsmasq_logdir)
* [`dnsmasq_package`](#-dnsmasq--dnsmasq_package)
* [`dnsmasq_service`](#-dnsmasq--dnsmasq_service)
* [`dnsmasq_package_provider`](#-dnsmasq--dnsmasq_package_provider)
* [`auth_sec_servers`](#-dnsmasq--auth_sec_servers)
* [`auth_server`](#-dnsmasq--auth_server)
* [`auth_ttl`](#-dnsmasq--auth_ttl)
* [`auth_zone`](#-dnsmasq--auth_zone)
* [`bogus_priv`](#-dnsmasq--bogus_priv)
* [`cache_size`](#-dnsmasq--cache_size)
* [`config_hash`](#-dnsmasq--config_hash)
* [`dhcp_boot`](#-dnsmasq--dhcp_boot)
* [`dhcp_leasefile`](#-dnsmasq--dhcp_leasefile)
* [`dhcp_no_override`](#-dnsmasq--dhcp_no_override)
* [`domain`](#-dnsmasq--domain)
* [`domain_needed`](#-dnsmasq--domain_needed)
* [`dns_forward_max`](#-dnsmasq--dns_forward_max)
* [`enable_tftp`](#-dnsmasq--enable_tftp)
* [`expand_hosts`](#-dnsmasq--expand_hosts)
* [`interface`](#-dnsmasq--interface)
* [`listen_address`](#-dnsmasq--listen_address)
* [`local_ttl`](#-dnsmasq--local_ttl)
* [`max_ttl`](#-dnsmasq--max_ttl)
* [`max_cache_ttl`](#-dnsmasq--max_cache_ttl)
* [`neg_ttl`](#-dnsmasq--neg_ttl)
* [`no_dhcp_interface`](#-dnsmasq--no_dhcp_interface)
* [`no_hosts`](#-dnsmasq--no_hosts)
* [`no_negcache`](#-dnsmasq--no_negcache)
* [`no_resolv`](#-dnsmasq--no_resolv)
* [`port`](#-dnsmasq--port)
* [`read_ethers`](#-dnsmasq--read_ethers)
* [`reload_resolvconf`](#-dnsmasq--reload_resolvconf)
* [`resolv_file`](#-dnsmasq--resolv_file)
* [`restart`](#-dnsmasq--restart)
* [`run_as_user`](#-dnsmasq--run_as_user)
* [`save_config_file`](#-dnsmasq--save_config_file)
* [`service_enable`](#-dnsmasq--service_enable)
* [`service_ensure`](#-dnsmasq--service_ensure)
* [`strict_order`](#-dnsmasq--strict_order)
* [`manage_tftp_root`](#-dnsmasq--manage_tftp_root)
* [`tftp_root`](#-dnsmasq--tftp_root)

##### <a name="-dnsmasq--dnsmasq_confdir"></a>`dnsmasq_confdir`

Data type: `Stdlib::Absolutepath`

Read all the files in the given directory as configuration files.

##### <a name="-dnsmasq--dnsmasq_conffile"></a>`dnsmasq_conffile`

Data type: `Stdlib::Absolutepath`

The location of the dnsmasq configuration file.

##### <a name="-dnsmasq--dnsmasq_hasstatus"></a>`dnsmasq_hasstatus`

Data type: `Boolean`

Whether the init script has status support.

##### <a name="-dnsmasq--dnsmasq_logdir"></a>`dnsmasq_logdir`

Data type: `Stdlib::Absolutepath`

The location of the dnsmasq log directory.

##### <a name="-dnsmasq--dnsmasq_package"></a>`dnsmasq_package`

Data type: `String[1]`

The name of the dnsmasq package.

##### <a name="-dnsmasq--dnsmasq_service"></a>`dnsmasq_service`

Data type: `String[1]`

The name of the dnsmasq service.

##### <a name="-dnsmasq--dnsmasq_package_provider"></a>`dnsmasq_package_provider`

Data type: `Optional[String[1]]`

Override the package provider for dnsmasq.

Default value: `undef`

##### <a name="-dnsmasq--auth_sec_servers"></a>`auth_sec_servers`

Data type: `Optional[Array[String[1]]]`

Specify any secondary servers for a zone for which dnsmasq is authoritative.

Default value: `undef`

##### <a name="-dnsmasq--auth_server"></a>`auth_server`

Data type: `Optional[String[1]]`

Enable authoritative DNS for queries on the specified interface or address.

Default value: `undef`

##### <a name="-dnsmasq--auth_ttl"></a>`auth_ttl`

Data type: `Optional[Integer]`

Specify the TTL for DNS records served from the authoritative DNS server.

Default value: `undef`

##### <a name="-dnsmasq--auth_zone"></a>`auth_zone`

Data type: `Optional[String[1]]`

Define a DNS zone for which dnsmasq acts as authoritative server.

Default value: `undef`

##### <a name="-dnsmasq--bogus_priv"></a>`bogus_priv`

Data type: `Boolean`

Reject DNS responses which contain private IP addresses.

Default value: `true`

##### <a name="-dnsmasq--cache_size"></a>`cache_size`

Data type: `Integer`

Set the size of dnsmasq's cache.

Default value: `1000`

##### <a name="-dnsmasq--config_hash"></a>`config_hash`

Data type: `Hash`

A hash of additional configuration options. This can be used to specify any additional
dnsmasq configuration that is not provided by the class's parameters.
The hash keys are the dnsmasq configuration option names, and the hash values are the configuration to use
for that option. For example:
```
class { 'dnsmasq':
  config_hash => {
    'dhcp-fqdn'          => true,
     'dhcp-authoritative' => true,
  },
}
```

Default value: `{}`

##### <a name="-dnsmasq--dhcp_boot"></a>`dhcp_boot`

Data type: `Optional[String[1]]`

Set the boot filename for netboot clients.

Default value: `undef`

##### <a name="-dnsmasq--dhcp_leasefile"></a>`dhcp_leasefile`

Data type: `Optional[Stdlib::Absolutepath]`

Specify the location of the DHCP lease file.

Default value: `undef`

##### <a name="-dnsmasq--dhcp_no_override"></a>`dhcp_no_override`

Data type: `Boolean`

Disable re-use of the DHCP servername and filename fields as extra option space.

Default value: `false`

##### <a name="-dnsmasq--domain"></a>`domain`

Data type: `Optional[Stdlib::Fqdn]`

Specify the domain name to be given to DHCP clients.

Default value: `undef`

##### <a name="-dnsmasq--domain_needed"></a>`domain_needed`

Data type: `Boolean`

Tell dnsmasq to never forward plain names (without a domain) to upstream nameservers.

Default value: `true`

##### <a name="-dnsmasq--dns_forward_max"></a>`dns_forward_max`

Data type: `Optional[Integer]`

Set the maximum number of concurrent DNS queries.

Default value: `undef`

##### <a name="-dnsmasq--enable_tftp"></a>`enable_tftp`

Data type: `Boolean`

Enable the built-in TFTP server.

Default value: `false`

##### <a name="-dnsmasq--expand_hosts"></a>`expand_hosts`

Data type: `Boolean`

Add the domain to plain names.

Default value: `true`

##### <a name="-dnsmasq--interface"></a>`interface`

Data type: `Optional[String[1]]`

Specify the interface dnsmasq should listen on.

Default value: `undef`

##### <a name="-dnsmasq--listen_address"></a>`listen_address`

Data type: `Optional[Stdlib::IP::Address::V4]`

Specify the address dnsmasq should listen on. Both `listen_address` and `interface` can be specified.

Default value: `undef`

##### <a name="-dnsmasq--local_ttl"></a>`local_ttl`

Data type: `Optional[Integer]`

Set the TTL for DNS records served from /etc/hosts or the DHCP lease file. This should normally be set to 0.

Default value: `undef`

##### <a name="-dnsmasq--max_ttl"></a>`max_ttl`

Data type: `Optional[Integer]`

Set the maximum TTL for DNS records served to clients. If the true TTL is greater than the `max_ttl`, then
the TTL is reduced to the `max_ttl`.

Default value: `undef`

##### <a name="-dnsmasq--max_cache_ttl"></a>`max_cache_ttl`

Data type: `Optional[Integer]`

Set the maximum TTL for records in the cache.

Default value: `undef`

##### <a name="-dnsmasq--neg_ttl"></a>`neg_ttl`

Data type: `Optional[Integer]`

Set the TTL for negative responses from upstream servers that do not provide a TTL from the SOA.

Default value: `undef`

##### <a name="-dnsmasq--no_dhcp_interface"></a>`no_dhcp_interface`

Data type: `Optional[Stdlib::IP::Address::V4::Nosubnet]`

Specify an interface that should not be used for DHCP or TFTP, only DNS.

Default value: `undef`

##### <a name="-dnsmasq--no_hosts"></a>`no_hosts`

Data type: `Boolean`

Disable reading of /etc/hosts.

Default value: `false`

##### <a name="-dnsmasq--no_negcache"></a>`no_negcache`

Data type: `Boolean`

Disable caching of negative responses.

Default value: `false`

##### <a name="-dnsmasq--no_resolv"></a>`no_resolv`

Data type: `Boolean`

Disable reading of /etc/resolv.conf.

Default value: `false`

##### <a name="-dnsmasq--port"></a>`port`

Data type: `Variant[Stdlib::Port,String[1]]`

Specify the port dnsmasq should listen on.

Default value: `'53'`

##### <a name="-dnsmasq--read_ethers"></a>`read_ethers`

Data type: `Boolean`

Read the Ethernet address from /etc/ethers and use it to set the DHCP provided hostname or IP address.

Default value: `false`

##### <a name="-dnsmasq--reload_resolvconf"></a>`reload_resolvconf`

Data type: `Boolean`

Use resolvconf(8) to notify clients of changes to /etc/resolv.conf.

Default value: `true`

##### <a name="-dnsmasq--resolv_file"></a>`resolv_file`

Data type: `Optional[Stdlib::Absolutepath]`

Read the IP addresses of the upstream nameservers from this file, instead of /etc/resolv.conf.

Default value: `undef`

##### <a name="-dnsmasq--restart"></a>`restart`

Data type: `Boolean`

Whether to restart the dnsmasq service when the configuration changes.

Default value: `true`

##### <a name="-dnsmasq--run_as_user"></a>`run_as_user`

Data type: `Optional[String[1]]`

Specify the user to run dnsmasq as.

Default value: `undef`

##### <a name="-dnsmasq--save_config_file"></a>`save_config_file`

Data type: `Boolean`

Whether to save the commented default config file after installation.

Default value: `true`

##### <a name="-dnsmasq--service_enable"></a>`service_enable`

Data type: `Boolean`

Whether the dnsmasq service should be enabled.

Default value: `true`

##### <a name="-dnsmasq--service_ensure"></a>`service_ensure`

Data type: `Stdlib::Ensure::Service`

Whether the dnsmasq service should be running or stopped.

Default value: `'running'`

##### <a name="-dnsmasq--strict_order"></a>`strict_order`

Data type: `Boolean`

Require DNS servers to be queried in the order specified by the `resolv_file`.

Default value: `true`

##### <a name="-dnsmasq--manage_tftp_root"></a>`manage_tftp_root`

Data type: `Boolean`

Whether to manage the TFTP root directory.

Default value: `false`

##### <a name="-dnsmasq--tftp_root"></a>`tftp_root`

Data type: `String[1]`

Specify the root directory for files available via TFTP.

Default value: `'/var/lib/tftpboot'`

## Defined types

### <a name="dnsmasq--address"></a>`dnsmasq::address`

Create a dnsmasq A record (--address).

* **See also**
  * hostrecord
    * for a more flexible way to create host records.

#### Examples

##### Create a dnsmasq A record

```puppet
dnsmasq::address { 'myhost':
  ip => '192.168.1.100'
}
```

#### Parameters

The following parameters are available in the `dnsmasq::address` defined type:

* [`ip`](#-dnsmasq--address--ip)

##### <a name="-dnsmasq--address--ip"></a>`ip`

Data type: `Stdlib::IP::Address::Nosubnet`

The IP address to assign to the hostname.

### <a name="dnsmasq--cname"></a>`dnsmasq::cname`

The dnsmasq::cname defined type creates an entry in the dnsmasq configuration file for a CNAME record

#### Examples

##### # Create a cname record for host1.example.com that points to host2.example.com

```puppet
dnsmasq::cname { 'host1.example.com':
  hostname => 'host2.example.com',
}
```

#### Parameters

The following parameters are available in the `dnsmasq::cname` defined type:

* [`name`](#-dnsmasq--cname--name)
* [`hostname`](#-dnsmasq--cname--hostname)

##### <a name="-dnsmasq--cname--name"></a>`name`

The name of the CNAME record to create

##### <a name="-dnsmasq--cname--hostname"></a>`hostname`

Data type: `Stdlib::Fqdn`

The hostname that the CNAME record should point to

### <a name="dnsmasq--dhcp"></a>`dnsmasq::dhcp`

The dnsmasq::dhcp class.

#### Parameters

The following parameters are available in the `dnsmasq::dhcp` defined type:

* [`dhcp_start`](#-dnsmasq--dhcp--dhcp_start)
* [`dhcp_end`](#-dnsmasq--dhcp--dhcp_end)
* [`netmask`](#-dnsmasq--dhcp--netmask)
* [`lease_time`](#-dnsmasq--dhcp--lease_time)
* [`tag`](#-dnsmasq--dhcp--tag)
* [`set`](#-dnsmasq--dhcp--set)
* [`mode`](#-dnsmasq--dhcp--mode)

##### <a name="-dnsmasq--dhcp--dhcp_start"></a>`dhcp_start`

Data type: `Stdlib::IP::Address::V4::Nosubnet`



##### <a name="-dnsmasq--dhcp--dhcp_end"></a>`dhcp_end`

Data type: `Stdlib::IP::Address::V4::Nosubnet`



##### <a name="-dnsmasq--dhcp--netmask"></a>`netmask`

Data type: `Variant[Integer,String[1]]`



##### <a name="-dnsmasq--dhcp--lease_time"></a>`lease_time`

Data type: `String[1]`



##### <a name="-dnsmasq--dhcp--tag"></a>`tag`

Data type: `Optional[String[1]]`



Default value: `undef`

##### <a name="-dnsmasq--dhcp--set"></a>`set`

Data type: `Optional[String[1]]`



Default value: `undef`

##### <a name="-dnsmasq--dhcp--mode"></a>`mode`

Data type: `Optional[String[1]]`



Default value: `undef`

### <a name="dnsmasq--dhcpboot"></a>`dnsmasq::dhcpboot`

Create an dnsmasq dhcp boot (PXE) record for customizing network
booting (--dhcp-boot).

#### Parameters

The following parameters are available in the `dnsmasq::dhcpboot` defined type:

* [`file`](#-dnsmasq--dhcpboot--file)
* [`tag`](#-dnsmasq--dhcpboot--tag)
* [`hostname`](#-dnsmasq--dhcpboot--hostname)
* [`bootserver`](#-dnsmasq--dhcpboot--bootserver)

##### <a name="-dnsmasq--dhcpboot--file"></a>`file`

Data type: `Stdlib::Absolutepath`



##### <a name="-dnsmasq--dhcpboot--tag"></a>`tag`

Data type: `Optional[String[1]]`



Default value: `undef`

##### <a name="-dnsmasq--dhcpboot--hostname"></a>`hostname`

Data type: `Optional[Stdlib::FQDN]`



Default value: `undef`

##### <a name="-dnsmasq--dhcpboot--bootserver"></a>`bootserver`

Data type: `Optional[Stdlib::IP::Address::V4::Nosubnet]`



Default value: `undef`

### <a name="dnsmasq--dhcpmatch"></a>`dnsmasq::dhcpmatch`

Create a dnsmasq dhcp match

#### Parameters

The following parameters are available in the `dnsmasq::dhcpmatch` defined type:

* [`content`](#-dnsmasq--dhcpmatch--content)
* [`paramtag`](#-dnsmasq--dhcpmatch--paramtag)

##### <a name="-dnsmasq--dhcpmatch--content"></a>`content`

Data type: `String[1]`



##### <a name="-dnsmasq--dhcpmatch--paramtag"></a>`paramtag`

Data type: `Optional[String[1]]`



Default value: `undef`

### <a name="dnsmasq--dhcpoption"></a>`dnsmasq::dhcpoption`

This definition allows for the creation and management of dnsmasq DHCP options,
providing a way to specify options with or without tags, and handling numeric
and named options appropriately.

If not explicitly provided, it defaults to the resource's title.
Numeric options and those starting with 'option:' are handled specifically.
The concat::fragment resource type used for managing parts of the dnsmasq configuration file.

* **See also**
  * dnsmasq
    * The main dnsmasq class that must be included before using this resource type.
  * concat::fragment

#### Examples

##### Create a DHCP option with a tag

```puppet
dnsmasq::dhcpoption { 'example-option':
  content => 'example-content',
  option  => 'example-option-name',
  tag     => 'example-tag',
}
```

#### Parameters

The following parameters are available in the `dnsmasq::dhcpoption` defined type:

* [`content`](#-dnsmasq--dhcpoption--content)
* [`option`](#-dnsmasq--dhcpoption--option)
* [`tag`](#-dnsmasq--dhcpoption--tag)

##### <a name="-dnsmasq--dhcpoption--content"></a>`content`

Data type: `String[1]`

The content of the DHCP option to be set.

##### <a name="-dnsmasq--dhcpoption--option"></a>`option`

Data type: `String[1]`

The name of the DHCP option.

Default value: `$title`

##### <a name="-dnsmasq--dhcpoption--tag"></a>`tag`

Data type: `Optional[String[1]]`

An optional tag to associate with the DHCP option. If not provided, no tag is applied.

Default value: `undef`

### <a name="dnsmasq--dhcpstatic"></a>`dnsmasq::dhcpstatic`

Create an dnsmasq stub zone for caching upstream name resolvers
(--dhcp-host).

#### Parameters

The following parameters are available in the `dnsmasq::dhcpstatic` defined type:

* [`mac`](#-dnsmasq--dhcpstatic--mac)
* [`ip`](#-dnsmasq--dhcpstatic--ip)

##### <a name="-dnsmasq--dhcpstatic--mac"></a>`mac`

Data type: `Stdlib::MAC`



##### <a name="-dnsmasq--dhcpstatic--ip"></a>`ip`

Data type: `Stdlib::IP::Address`



### <a name="dnsmasq--dnsrevserver"></a>`dnsmasq::dnsrevserver`

Configure the DNS server to query sub domains to external DNS servers
(--rev-server).

#### Parameters

The following parameters are available in the `dnsmasq::dnsrevserver` defined type:

* [`ip`](#-dnsmasq--dnsrevserver--ip)
* [`netmask`](#-dnsmasq--dnsrevserver--netmask)
* [`subnet`](#-dnsmasq--dnsrevserver--subnet)
* [`port`](#-dnsmasq--dnsrevserver--port)

##### <a name="-dnsmasq--dnsrevserver--ip"></a>`ip`

Data type: `Stdlib::IP::Address::V4::Nosubnet`



##### <a name="-dnsmasq--dnsrevserver--netmask"></a>`netmask`

Data type: `Integer[0,32]`



##### <a name="-dnsmasq--dnsrevserver--subnet"></a>`subnet`

Data type: `Stdlib::IP::Address::V4`



##### <a name="-dnsmasq--dnsrevserver--port"></a>`port`

Data type: `Optional[Stdlib::Port]`



Default value: `undef`

### <a name="dnsmasq--dnsrr"></a>`dnsmasq::dnsrr`

Create an dnsmasq dnsrr record (--dns-rr).

#### Parameters

The following parameters are available in the `dnsmasq::dnsrr` defined type:

* [`domain`](#-dnsmasq--dnsrr--domain)
* [`type`](#-dnsmasq--dnsrr--type)
* [`rdata`](#-dnsmasq--dnsrr--rdata)

##### <a name="-dnsmasq--dnsrr--domain"></a>`domain`

Data type: `Stdlib::FQDN`



##### <a name="-dnsmasq--dnsrr--type"></a>`type`

Data type: `Pattern[/^[a-fA-F0-9]+$/]`



##### <a name="-dnsmasq--dnsrr--rdata"></a>`rdata`

Data type: `Pattern[/^[a-f0-9 :]+$/]`



### <a name="dnsmasq--dnsserver"></a>`dnsmasq::dnsserver`

Configure the DNS server to query sub domains to external DNS servers
(--server).

#### Parameters

The following parameters are available in the `dnsmasq::dnsserver` defined type:

* [`ip`](#-dnsmasq--dnsserver--ip)
* [`domain`](#-dnsmasq--dnsserver--domain)
* [`port`](#-dnsmasq--dnsserver--port)

##### <a name="-dnsmasq--dnsserver--ip"></a>`ip`

Data type: `Stdlib::IP::Address::Nosubnet`



##### <a name="-dnsmasq--dnsserver--domain"></a>`domain`

Data type: `Optional[Stdlib::FQDN]`



Default value: `undef`

##### <a name="-dnsmasq--dnsserver--port"></a>`port`

Data type: `Optional[Stdlib::Port]`



Default value: `undef`

### <a name="dnsmasq--domain"></a>`dnsmasq::domain`

Create a dnsmasq domain (--domain).

#### Parameters

The following parameters are available in the `dnsmasq::domain` defined type:

* [`subnet`](#-dnsmasq--domain--subnet)
* [`local`](#-dnsmasq--domain--local)

##### <a name="-dnsmasq--domain--subnet"></a>`subnet`

Data type: `Optional[Stdlib::IP::Address]`



Default value: `undef`

##### <a name="-dnsmasq--domain--local"></a>`local`

Data type: `Boolean`



Default value: `false`

### <a name="dnsmasq--hostrecord"></a>`dnsmasq::hostrecord`

Create a dnsmasq A,AAAA and PTR record (--host-record).

#### Examples

##### Create a host record with a single IPv4 address

```puppet
dnsmasq::hostrecord { 'example':
  ip => '192.168.0.1',
}
```

##### Create a host record with multiple IPv4 addresses

```puppet
dnsmasq::hostrecord { 'example':
  ip => ['192.168.0.1', '192.168.0.2'],
}
```

##### Create a host record with an IPv4 and an IPv6 address

```puppet
dnsmasq::hostrecord { 'example':
  ip => '192.168.0.1',
  ipv6 => '2001:0db8:85a3:0000:0000:8a2e:0370:7334',
}
```

#### Parameters

The following parameters are available in the `dnsmasq::hostrecord` defined type:

* [`ip`](#-dnsmasq--hostrecord--ip)
* [`ipv6`](#-dnsmasq--hostrecord--ipv6)

##### <a name="-dnsmasq--hostrecord--ip"></a>`ip`

Data type: `Variant[Stdlib::IP::Address::V4::Nosubnet, Array[Stdlib::IP::Address::V4::Nosubnet]]`

The IPv4 address or an array of IPv4 addresses for the host record.
Each IP address should be a string in the format of 'x.x.x.x', where each x is a number from 0 to 255.

##### <a name="-dnsmasq--hostrecord--ipv6"></a>`ipv6`

Data type: `Optional[Stdlib::IP::Address::V6::Nosubnet]`

The optional IPv6 address for the host record.
The IP address should be a string in the format of 'x:x:x:x:x:x:x:x', where each x is a hexadecimal number from 0 to FFFF.

Default value: `undef`

### <a name="dnsmasq--mx"></a>`dnsmasq::mx`

Create an dnsmasq mx record (--mx-host).

#### Parameters

The following parameters are available in the `dnsmasq::mx` defined type:

* [`mx_name`](#-dnsmasq--mx--mx_name)
* [`hostname`](#-dnsmasq--mx--hostname)
* [`preference`](#-dnsmasq--mx--preference)

##### <a name="-dnsmasq--mx--mx_name"></a>`mx_name`

Data type: `String[1]`



Default value: `$name`

##### <a name="-dnsmasq--mx--hostname"></a>`hostname`

Data type: `Optional[String[1]]`



Default value: `undef`

##### <a name="-dnsmasq--mx--preference"></a>`preference`

Data type: `Optional[String[1]]`



Default value: `undef`

### <a name="dnsmasq--ptr"></a>`dnsmasq::ptr`

Create an dnsmasq ptr record (--ptr-record).

#### Parameters

The following parameters are available in the `dnsmasq::ptr` defined type:

* [`value`](#-dnsmasq--ptr--value)

##### <a name="-dnsmasq--ptr--value"></a>`value`

Data type: `String[1]`



### <a name="dnsmasq--srv"></a>`dnsmasq::srv`

Create an dnsmasq srv record (--srv-host).

#### Parameters

The following parameters are available in the `dnsmasq::srv` defined type:

* [`hostname`](#-dnsmasq--srv--hostname)
* [`port`](#-dnsmasq--srv--port)
* [`priority`](#-dnsmasq--srv--priority)

##### <a name="-dnsmasq--srv--hostname"></a>`hostname`

Data type: `Stdlib::Host`



##### <a name="-dnsmasq--srv--port"></a>`port`

Data type: `Stdlib::Port`



##### <a name="-dnsmasq--srv--priority"></a>`priority`

Data type: `Optional[Variant[String, Integer]]`



Default value: `undef`

### <a name="dnsmasq--txt"></a>`dnsmasq::txt`

Create an dnsmasq txt record (--txt-record).

#### Parameters

The following parameters are available in the `dnsmasq::txt` defined type:

* [`value`](#-dnsmasq--txt--value)

##### <a name="-dnsmasq--txt--value"></a>`value`

Data type: `Variant[String[1],Array[String[1]]]`


