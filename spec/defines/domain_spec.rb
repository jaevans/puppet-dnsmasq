require 'spec_helper'

describe 'dnsmasq::domain', type: 'define' do
  on_supported_os.each do |os, os_facts|
    let(:facts) { os_facts }
    let(:title) { 'example.com' }

    context "with no params on #{os}" do
      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-domain-example.com').with(
          order: '06',
          target: 'dnsmasq.conf',
          content: "domain=example.com\n",
        )
      end
    end

    context "with all params on #{os}" do
      let :params do
        {
          subnet: '192.168.0.0/24',
        local: true,
        }
      end

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-domain-example.com').with(
          order: '06',
          target: 'dnsmasq.conf',
          content: "domain=example.com,192.168.0.0/24,local\n",
        )
      end
    end
  end
end
