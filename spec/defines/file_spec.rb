require 'spec_helper'

describe 'puppet_audit::file' do
  let(:title) { 'namevar' }
  let(:params) do
    {
      'checksum'      =>  '0c4305ed79b2292299b00ebcb691a0e4',
      'checksum_type' =>  'md5',
      'group'         =>  'foo',
      'mode'          =>  '0777',
      'owner'         =>  'foo',
      'tags'          =>  :undef,
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
