require 'spec_helper'

describe 'puppet_audit' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "puppet_audit class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('puppet_audit::params') }
        it { should contain_class('puppet_audit::install').that_comes_before('puppet_audit::config') }
        it { should contain_class('puppet_audit::config') }
        it { should contain_class('puppet_audit::service').that_subscribes_to('puppet_audit::config') }

        it { should contain_service('puppet_audit') }
        it { should contain_package('puppet_audit').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'puppet_audit class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('puppet_audit') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
