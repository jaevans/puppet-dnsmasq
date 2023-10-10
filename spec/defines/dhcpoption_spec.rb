require 'spec_helper'

describe 'dnsmasq::dhcpoption', type: 'define' do
  on_supported_os.each do |os, os_facts|
    let(:facts) { os_facts }
    let :title  do 'option:ntp-server' end

    context "with no params on #{os}" do
      it 'raises error due no params' do
        expect { is_expected.to compile.and_raise_error(/expects a value/) }
      end
    end

    context "with minimal parms on #{os}" do
      let :params do 
        { 
          content: '192.168.0.4' 
        }
      end

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-dhcpoption-option:ntp-server').with(
          order: '03',
          target: 'dnsmasq.conf',
          content: "dhcp-option=option:ntp-server,192.168.0.4\n",
        )
      end
    end

    context "with all parms on #{os}" do
      let :params do
        {
          content: '192.168.0.4',
          tag: 'foo',
        }
      end

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-dhcpoption-option:ntp-server').with(
          order: '03',
          target: 'dnsmasq.conf',
          content: "dhcp-option=tag:foo,option:ntp-server,192.168.0.4\n",
        )
      end
    end
  end
end