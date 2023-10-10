require 'spec_helper'

describe 'dnsmasq::txt', type: 'define' do
  on_supported_os.each do |os, os_facts|
    let(:facts) { os_facts }
    let(:title) { 'foo' }

    context "with no params on #{os}" do
      it 'raises error due no params' do
        expect { is_expected.to compile.and_raise_error(%r{expects a value}) }
        # expect { is_expected.to compile }.to raise_error(Puppet::Error, %r{Must pass})
      end
    end

    context "with one value on #{os}" do
      let(:params) { { value: 'bar' } }

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-txt-foo').with(
          order: '11',
          target: 'dnsmasq.conf',
          content: "txt-record=foo,bar\n",
        )
      end
    end

    context "with multiple values on #{os}" do
      let(:params) { { value: ['bar', 'baz'] } }

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-txt-foo').with(
          order: '11',
          target: 'dnsmasq.conf',
          content: "txt-record=foo,bar,baz\n",
        )
      end
    end
  end
end
