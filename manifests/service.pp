# == Class puppet_audit::service
#
# This class is meant to be called from puppet_audit
# It ensure the service is running
#
class puppet_audit::service {

  service { $puppet_audit::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
