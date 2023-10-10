require 'spec_helper'

describe 'dnsmasq::dhcpstatic', type: 'define' do
  on_supported_os.each do |os, os_facts|
    let(:facts) { os_facts }
    let(:title) { 'example.com' }

    context "with no params on #{os}" do
      it 'raises error due no params' do
        expect { is_expected.to compile.and_raise_error(%r{expects a value}) }
      end
    end

    context "with params on #{os}" do
      let :params do
        {
          mac: '4C:72:B9:31:8C:B9',
        ip: '192.168.0.4',
        }
      end

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-staticdhcp-example.com').with(
          order: '05',
          target: 'dnsmasq.conf',
          content: "dhcp-host=4c:72:b9:31:8c:b9,192.168.0.4,example.com\n",
        )
      end
    end
  end
end
