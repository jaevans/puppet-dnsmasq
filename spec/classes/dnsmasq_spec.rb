require 'spec_helper'

describe 'dnsmasq', type: 'class' do
  shared_examples 'supported' do
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('dnsmasq') }
    it {
      is_expected.to contain_concat('dnsmasq.conf').that_requires('Package[dnsmasq]')
    }
    it {
      is_expected.to contain_concat__fragment('dnsmasq-header').with({
         name: 'dnsmasq-header',
        order: '00',
        target: 'dnsmasq.conf',
        content: %r{^# MAIN CONFIG START\ndomain-needed\nbogus-priv},
      })
    }
    it {
      is_expected.to contain_package('dnsmasq').that_comes_before('Service[dnsmasq]')
    }
    it { is_expected.to contain_service('dnsmasq') }
    it { is_expected.to contain_exec('reload_resolvconf') }
    it { is_expected.to contain_exec('save_config_file') }
    it { is_expected.to contain_file('/etc/dnsmasq.d') }
  end

  on_supported_os.each do |os, os_facts|
    let(:facts) { os_facts }
    context "on OS #{os}" do
      # let :facts do facts end

      it_behaves_like 'supported'
      case os_facts[:os]['family']
      when 'Darwin'
        it {
          is_expected.to contain_concat('dnsmasq.conf').with_path('/opt/local/etc/dnsmasq.conf')
        }
        it {
          is_expected.to contain_package('dnsmasq').with(
            {
              name: 'dnsmasq',
              provider: 'macports',
            },
          )
        }
      when 'Debian', 'RedHat'
        it {
          is_expected.to contain_concat('dnsmasq.conf').with_path('/etc/dnsmasq.conf')
        }
        it {
          is_expected.to contain_package('dnsmasq').with(
            {
              name: 'dnsmasq',
              provider: nil,
            },
          )
        }
      when 'DragonFly', 'FreeBSD'
        it {
          is_expected.to contain_concat('dnsmasq.conf').with_path('/usr/local/etc/dnsmasq.conf')
        }
        it {
          is_expected.to contain_package('dnsmasq').with(
            {
              name: 'dns/dnsmasq',
              provider: nil,
            },
          )
        }
      end
    end
  end

  context 'with reload_resolvconf = false' do
    let(:params) { { reload_resolvconf: false } }

    it { is_expected.not_to contain_exec('reload_resolvconf') }
  end

  context 'with save_config_file = false' do
    let(:params) { { save_config_file: false } }

    it { is_expected.not_to contain_exec('save_config_file') }
  end

  # Test our booleans
  [ 'bogus_priv',
    'domain_needed',
    'dhcp_no_override',
    'enable_tftp',
    'expand_hosts',
    'no_hosts',
    'no_negcache',
    'no_resolv',
    'read_ethers',
    'strict_order'].each do |i|
    param = i.tr('_', '-')

    context "with #{i} = true" do
      let(:params) { { i => true } }

      it {
        is_expected.to contain_concat__fragment('dnsmasq-header').with_content(
        %r{\n#{param}\n},
      )
      }
    end

    context "with #{i} = false" do
      let(:params) { { i => false } }

      it {
        is_expected.to contain_concat__fragment('dnsmasq-header').with_content(
        %r{(?!#{param})},
      )
      }
    end
  end
end
