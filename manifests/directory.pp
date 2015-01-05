# == Class puppet_audit::files
#
define puppet_audit::directory(
  $dirpath = "${title}"
  $dirMD5v
  $tags => ""
  )
  {
    file { "${dirpath}" :
      ensure => file,
      content => "${dirMD5}",
      noop => true,
      replace => false,
      tag => ${tags},
    }
    
    
  }
}
