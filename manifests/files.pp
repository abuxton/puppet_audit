# == Class puppet_audit::files
#
define puppet_audit::files(
  $filepath = "${title}"
  $fileMD5v
  )
  {
    file { "${filepath}" :
      ensure => file,
      content => "${fileMD5}",
      noop => true,
      replace => false,
    }
    
    
  }
}
