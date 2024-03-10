require 'spec_helper'

describe 'dnsmasq::hostrecord', type: 'define' do
  on_supported_os.each do |os, os_facts|
    let(:facts) { os_facts }
    let(:title) { 'example.com' }

    context "with no params on #{os}" do
      it 'raises error due no params' do
        expect { is_expected.to compile.and_raise_error(%r{expects a value}) }
      end
    end

    context "with hostname on #{os}" do
      let(:params) { { ip: '192.168.0.4' } }

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-hostrecord-example.com').with(
          order: '07',
          target: 'dnsmasq.conf',
          content: "host-record=example.com,192.168.0.4\n",
        )
      end
    end

    context "with different title on #{os}" do
      let(:title) { 'host.example.com' }
      let(:params) { { name: 'foo.example.com', ip: '192.168.0.4' } }

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-hostrecord-host.example.com').with(
          order: '07',
          target: 'dnsmasq.conf',
          content: "host-record=foo.example.com,192.168.0.4\n",
        )
      end
    end
  end
end
