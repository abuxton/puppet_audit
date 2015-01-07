# == Class puppet_audit::params
#
# This class is meant to be called from puppet_audit
# It sets variables according to platform
#
#
#file { '/tmp/afile.txt':
#  ensure  => 'file',
#  content => '{md5}d8e8fca2dc0f896fd7cb4cb0031ba249',
#  group   => '0',
#  mode    => '644',
#  owner   => '501',
#  type    => 'file',
#}

class puppet_audit::params {
  case $operatingsystem {
    "Centos": {
      $filepath = "/tmp/afile.txt"
      $dirpath = "/tmp"
      $linkfilepath = "/tmp"
      $fileMD5  = '{md5}28356c0751810f8f709db4ef444bd5d4' 
      $group    = '0'
      $mode     = '644'
      $owner    = '501'
      $target   = '/private/tmp'
      $tags     = ""
    
    }
    default: {
      $filepath = undef
      $fileMD5  = undef
      $group    = undef
      $mode     = undef
      $owner    = undef
      $target   = undef
      $tags     = undef
    }
  } 
}
