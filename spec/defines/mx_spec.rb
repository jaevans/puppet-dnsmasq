require 'spec_helper'

describe 'dnsmasq::mx', type: 'define' do
  on_supported_os.each do |os, os_facts|
    let(:facts) { os_facts }
    let(:title) { 'example.com' }

    context "with no params on #{os}" do
      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-mx-example.com').with(
          order: '08_example.com__',
          target: 'dnsmasq.conf',
          content: "mx-host=example.com\n",
        )
      end
    end

    context "with all params on #{os}" do
      let :params do
        {
          mx_name: 'my.example.com',
          hostname: 'example.com',
          preference: '50',
        }
      end

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-mx-example.com').with(
          order: '08_my.example.com_,example.com_,50',
          target: 'dnsmasq.conf',
          content: "mx-host=my.example.com,example.com,50\n",
        )
      end
    end
  end
end
