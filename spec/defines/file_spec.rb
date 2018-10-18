require 'spec_helper'

describe 'puppet_audit::file' do
  let(:title) { '/namevar' }
  let(:params) do
    {
      'checksum_value'  =>  :undef,
      'checksum'        =>  :undef,
      'group'           =>  'foo',
      'mode'            =>  '0777',
      'owner'           =>  'foo',
      'tags'            =>  :undef,
      'source'          =>  :undef,
      'content'         =>  :undef,
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
end
