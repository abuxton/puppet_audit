require 'spec_helper'

describe 'puppet_audit::files', type => :define  do
let(:title) { '/tmp/afile.txt' }
  let(:params) {
    {
      :filepath =>  '/tmp/afile.txt',
      :fileMD5  =>  '{md5}',
      :owner    =>  '',
      :group    =>  '',
      :mode     =>  '',
      :
    }
  }
  it do
    should contain file('/tmp/afile.txt').with(
      'ensure'  =>  'file',
      'content' =>  '',
      'owner'   =>  '',
      'group'   =>  '',
      'mode'    =>  '',
      'replace' =>  'true',
      'noop'    =>  'true',
      )
  end
end
