require 'spec_helper'

describe 'puppet_audit::link' do
  let(:title) { '/namevar' }
  let(:params) do
    {
      'group'         =>  'foo',
      'mode'          =>  '0777',
      'owner'         =>  'foo',
      'target'        =>  '/namevar/target',
      'tags'          =>  :nil,
      'linkfilepath'  =>  '/namevar',
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
end
