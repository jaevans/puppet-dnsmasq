require 'spec_helper'

describe 'dnsmasq::ptr', type: 'define' do
  on_supported_os.each do |os, os_facts|
    let :title  do 'foo.com' end
    let(:facts) { os_facts }

    context "with no params on #{os}" do
      it 'raises error due no params' do
        expect { is_expected.to compile.and_raise_error(/expects a value/) }
      end
    end

    context "with value on #{os}" do
      let :params do { value: 'example.com' } end

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-ptr-foo.com').with(
          order: '10',
          target: 'dnsmasq.conf',
          content: "ptr-record=foo.com,example.com\n",
        )
      end
    end
  end
end