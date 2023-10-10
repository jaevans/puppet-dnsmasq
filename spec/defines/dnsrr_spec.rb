require 'spec_helper'

describe 'dnsmasq::dnsrr', type: 'define' do
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
          domain: 'example.com',
          type: '51',
          rdata: '01 23 45',
        }
      end

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-dnsrr-foo').with(
          order: '12',
          target: 'dnsmasq.conf',
          content: "dns-rr=example.com,51,012345\n",
        )
      end
    end
    context "with other params on #{os}" do
      let :params do
        {
          domain: 'example.com',
        type: '51',
        rdata: '01:23:45',
        }
      end

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-dnsrr-foo').with(
          order: '12',
          target: 'dnsmasq.conf',
          content: "dns-rr=example.com,51,012345\n",
        )
      end
    end
  end
end