require 'spec_helper'

describe 'dnsmasq::dnsserver', type: 'define' do
  on_supported_os.each do |os, os_facts|
    let(:facts) { os_facts }
    let(:title) { 'foo' }

    context "with no params on #{os}" do
      it 'raises error due no params' do
        expect { is_expected.to compile.and_raise_error(%r{expects a value}) }
      end
    end

    context "with minimal params #{os}" do
      let(:params) { { ip: '192.168.0.4' } }

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-dnsserver-foo').with(
          order: '13',
          target: 'dnsmasq.conf',
          content: "server=192.168.0.4\n",
        )
      end
    end

    context "with all params on #{os}" do
      let :params do
        {
          ip: '192.168.0.4',
        domain: 'example.com',
        }
      end

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-dnsserver-foo').with(
          order: '13',
          target: 'dnsmasq.conf',
          content: "server=/example.com/192.168.0.4\n",
        )
      end
    end
  end
end
