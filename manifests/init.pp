# == Class: puppet_audit
#
# Full description of class puppet_audit here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class puppet_audit (
  $package_name = $puppet_audit::params::package_name,
  $service_name = $puppet_audit::params::service_name,
) inherits puppet_audit::params {

  # validate parameters here

  class { 'puppet_audit::config': } ~>
  class { 'puppet_audit::directory': } ->
  class { 'puppet_audit::files'}->
  Class['puppet_audit']
}
