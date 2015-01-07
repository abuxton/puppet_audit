require 'spec_helper'

describe 'puppet_audit' do
  context 'supported operating systems' do
    ['Darwin', 'Redhat'].each do |operatingsystem|
      describe "puppet_audit class without any parameters on #{operatingsystem}" do
        let(:params) {{ }}
        let(:facts) {{
          :operatingsystem => operatingsystem,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('puppet_audit::params') }
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
