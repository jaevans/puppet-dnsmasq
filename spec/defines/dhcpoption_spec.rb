require 'spec_helper'

describe 'dnsmasq::dhcpoption', type: 'define' do
  describe 'with text option including option:' do
    let(:title) { 'option:ntp-server' }

    on_supported_os.each do |os, os_facts|
      let(:facts) { os_facts }

      context "with no params on #{os}" do
        it 'raises error due no params' do
          expect { is_expected.to compile.and_raise_error(%r{expects a value}) }
        end
      end

      context "with minimal parms on #{os}" do
        let(:params) { { content: '192.168.0.4' } }

        it do
          is_expected.to contain_class('dnsmasq')
          is_expected.to contain_concat__fragment('dnsmasq-dhcpoption--option:ntp-server').with(
            order: '03',
            target: 'dnsmasq.conf',
            content: "dhcp-option=option:ntp-server,192.168.0.4\n",
          )
        end
      end

      context "with all parms on #{os}" do
        let :params do
          {
            content: '192.168.0.4',
            tag: 'foo',
          }
        end

        it do
          is_expected.to contain_class('dnsmasq')
          is_expected.to contain_concat__fragment('dnsmasq-dhcpoption-foo-option:ntp-server').with(
            order: '03',
            target: 'dnsmasq.conf',
            content: "dhcp-option=tag:foo,option:ntp-server,192.168.0.4\n",
          )
        end
      end
    end
  end

  describe 'with text option without option:' do
    let(:title) { 'ntp-server' }

    on_supported_os.each do |os, os_facts|
      let(:facts) { os_facts }

      context "with minimal parms on #{os}" do
        let(:params) { { content: '192.168.0.4' } }

        it do
          is_expected.to contain_class('dnsmasq')
          is_expected.to contain_concat__fragment('dnsmasq-dhcpoption--ntp-server').with(
            order: '03',
            target: 'dnsmasq.conf',
            content: "dhcp-option=option:ntp-server,192.168.0.4\n",
          )
        end
      end

      context "with all parms on #{os}" do
        let :params do
          {
            content: '192.168.0.4',
            tag: 'foo',
          }
        end

        it do
          is_expected.to contain_class('dnsmasq')
          is_expected.to contain_concat__fragment('dnsmasq-dhcpoption-foo-ntp-server').with(
            order: '03',
            target: 'dnsmasq.conf',
            content: "dhcp-option=tag:foo,option:ntp-server,192.168.0.4\n",
          )
        end
      end
    end
  end

  describe 'with numeric option' do
    let(:title) { '121' }

    on_supported_os.each do |os, os_facts|
      let(:facts) { os_facts }

      context "with minimal parms on #{os}" do
        let(:params) { { content: '192.168.0.5' } }

        it do
          is_expected.to contain_class('dnsmasq')
          is_expected.to contain_concat__fragment('dnsmasq-dhcpoption--121').with(
            order: '03',
            target: 'dnsmasq.conf',
            content: "dhcp-option=121,192.168.0.5\n",
          )
        end
      end

      context "with all parms on #{os}" do
        let :params do
          {
            content: '192.168.0.4',
            tag: 'foo',
          }
        end

        it do
          is_expected.to contain_class('dnsmasq')
          is_expected.to contain_concat__fragment('dnsmasq-dhcpoption-foo-121').with(
            order: '03',
            target: 'dnsmasq.conf',
            content: "dhcp-option=tag:foo,121,192.168.0.4\n",
          )
        end
      end
    end
  end
end
