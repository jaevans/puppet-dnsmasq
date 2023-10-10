require 'spec_helper'

describe 'dnsmasq::dhcp', type: 'define' do
  on_supported_os.each do |os, os_facts|
    let(:facts) { os_facts }
    let :title  do 'foo' end

    context "with no params on #{os}" do
      it 'raises error due no params' do
        expect { is_expected.to compile.and_raise_error(/expects a value/) }
      end
    end

    context "with params on #{os}" do
      let :params do
        {
          dhcp_start: '1.2.3.128',
          dhcp_end: '1.2.3.192',
          netmask: '24',
          lease_time: '1h',
        }
      end

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-dhcprange-foo').with(
          order: '01',
          target: 'dnsmasq.conf',
          content: "dhcp-range=1.2.3.128,1.2.3.192,24,1h\n",
        )
      end
    end
  end
end