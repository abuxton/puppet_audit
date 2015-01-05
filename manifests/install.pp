# == Class puppet_audit::install
#
class puppet_audit::install {

  package { $puppet_audit::package_name:
    ensure => present,
  }
}
