# == Class puppet_audit::params
#
# This class is meant to be called from puppet_audit
# It sets variables according to platform
#
class puppet_audit::params {
  case $operatingsystem {
  "Darwin": {
  $filepath = "/tmp/afile.txt"
  $dirpath  = "/tmp"
#md5 /tmp/afile.txt
#MD5 (/tmp/afile.txt) = d41d8cd98f00b204e9800998ecf8427e
#$ tree /tmp/
#/tmp/
#└── afile.txt
  $fileMD5  = '{md5}d41d8cd98f00b204e9800998ecf8427e' 
  $dirMD5   = undef
  $tags     = ""
  }
  default: {
  $filepath = undef
  $dirpath  = undef
  $fileMD5  = undef
  $dirMD5   = undef
  $tags     = undef
  }
}

