require 'spec_helper'

describe 'dnsmasq::srv', type: 'define' do
  on_supported_os.each do |os, os_facts|
    let(:title) { '_xmpp-server._tcp.example.com' }
    let(:facts) { os_facts }

    context "with no params on #{os}" do
      it 'raises error due no params' do
        expect { is_expected.to compile.and_raise_error(%r{expects a value}) }
      end
    end

    context "with minimal params on #{os}" do
      let(:params) do
        {
          hostname: 'example.com',
          port: 5333,
        }
      end

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment(
          'dnsmasq-srv-_xmpp-server._tcp.example.com',
        ).with(
          order: '09',
          target: 'dnsmasq.conf',
          content: "srv-host=_xmpp-server._tcp.example.com,example.com,5333\n",
        )
      end
    end

    context "with all params on #{os}" do
      let(:params) do
        {
          hostname: 'example.com',
          port: 5333,
          priority: '11',
        }
      end

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment(
          'dnsmasq-srv-_xmpp-server._tcp.example.com',
        ).with(
          order: '09',
          target: 'dnsmasq.conf',
          content:         "srv-host=_xmpp-server._tcp.example.com,example.com,5333,11\n",
        )
      end
    end
  end
end
