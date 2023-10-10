require 'spec_helper'

describe 'dnsmasq::address', type: 'define' do
  on_supported_os.each do |os, os_facts|
    let(:facts) { os_facts }
    let :title  do 'example.com' end

    context "with no params on #{os}" do
      it 'raises error due no params' do
        expect { is_expected.to compile.and_raise_error(/expects a value/) }
      end
    end

    context "with ip on #{os}" do
      let :params do { ip: '192.168.0.4' } end

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-staticdns-example.com').with(
          order: '07_example.com',
          target: 'dnsmasq.conf',
          content: "address=/example.com/192.168.0.4\n",
        )
      end
    end
  end
end