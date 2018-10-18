require 'spec_helper'

describe 'puppet_audit' do
  context 'supported operating systems' do
    ['Darwin', 'Redhat'].each do |operatingsystem|
      describe "puppet_audit class without any parameters on #{operatingsystem}" do
        let(:params) { {} }
        let(:facts) do
          {
            operatingsystem: operatingsystem,
          }
        end

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('puppet_audit::params') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'puppet_audit class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          osfamily: 'Solaris',
          operatingsystem: 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('puppet_audit') }.to raise_error(Puppet::Error, %r{Nexenta not supported}) }
    end
  end
end
