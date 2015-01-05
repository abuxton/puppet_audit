# == Class puppet_audit::files
#
define puppet_audit::files(
  $filepath = "${title}",
  $fileMD5,
  $tags = '',
  )
  {
    case $tags{
    '': {
      
      file { "${filepath}" :
        ensure => file,
        content => "${fileMD5}",
        noop => true,
        replace => true,
      } 
    }
    default:  {
      file { "${filepath}" :
        ensure => file,
        content => "${fileMD5}",
        noop => true,
        replace => true,
        tag => "${tags}",
      }
    }
  }
}

