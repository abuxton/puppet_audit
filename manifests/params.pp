# == Class puppet_audit::params
#
# This class is meant to be called from puppet_audit
# It sets variables according to platform
#
class puppet_audit::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'puppet_audit'
      $service_name = 'puppet_audit'
    }
    'RedHat', 'Amazon': {
      $package_name = 'puppet_audit'
      $service_name = 'puppet_audit'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
