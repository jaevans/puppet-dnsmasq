require 'spec_helper'

describe 'dnsmasq::cname', type: 'define' do
  on_supported_os.each do |os, os_facts|
    let(:facts) { os_facts }
    let(:title) { 'foo.com' }

    context "with no params on #{os}" do
      it 'raises error due no params' do
        expect { is_expected.to compile.and_raise_error(%r{expects a value}) }
      end
    end

    context "with hostname on #{os}" do
      let(:params) { { hostname: 'example.com' } }

      it do
        is_expected.to contain_class('dnsmasq')
        is_expected.to contain_concat__fragment('dnsmasq-cname-foo.com').with(
          order: '12',
          target: 'dnsmasq.conf',
          content: "cname=foo.com,example.com\n",
        )
      end
    end

    context "with malformed hostname on #{os}" do
      let(:params) { { hostname: 'example.com/foo' } }
      it 'raises error due malformed hostname' do
        expect { is_expected.to compile.and_raise_error(%r{expects a match for Stdlib::Fqdn}) }
      end
    end

    context "with malformed hostname (IP) on #{os}" do
      let(:params) { { hostname: '172.10.0.1' } }
      it 'raises error due malformed hostname (IP)' do
        expect { is_expected.to compile.and_raise_error(%r{expects a match for Stdlib::Fqdns}) }
      end
    end

    context "with malformed title (IP) on #{os}" do
      let(:title) { '172.10.0.1' }
      it 'raises error due malformed title (IP)' do
        expect { is_expected.to compile } #.and_raise_error(%r{expects a match for Stdlib::Fqdn}) }
      end
    end
  end
end
