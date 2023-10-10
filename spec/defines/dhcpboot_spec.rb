require 'spec_helper'

describe 'dnsmasq::dhcpboot', type: 'define' do
  on_supported_os.each do |os, os_facts|
    let(:facts) { os_facts }
    let(:title) { 'foo' }

    context "with no params on #{os}" do
      it 'raises error due no params' do
        expect { is_expected.to compile.and_raise_error(%r{expects a value}) }
      end
    end

    context "with minimal params on #{os}" do
      let(:params) { { file: '/foo' } }

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-dhcpboot-foo').with(
          order: '04',
          target: 'dnsmasq.conf',
          content: "dhcp-boot=/foo\n",
        )
      end
    end

    context "with all params on #{os}" do
      let :params do
        {
          file: '/foo',
        hostname: 'example.com',
        bootserver: '192.168.0.4',
        tag: 'bar',
        }
      end

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-dhcpboot-foo').with(
          order: '04',
          target: 'dnsmasq.conf',
          content: "dhcp-boot=tag:bar,/foo,example.com,192.168.0.4\n",
        )
      end
    end
  end
end
