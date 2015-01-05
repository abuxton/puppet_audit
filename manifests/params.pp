# == Class puppet_audit::params
#
# This class is meant to be called from puppet_audit
# It sets variables according to platform
#
class puppet_audit::params {
  $filepath = undef
  $dirpath  = undef
  $fileMD5  = undef
  $dirMD5   = undef
  $tags     = undef
  
}

