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
    "Darwin": {
      $filepath = "/tmp/afile.txt"
      $dirpath = "/tmp"
      $fileMD5  = '{md5}d41d8cd98f00b204e9800998ecf8427e' 
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
