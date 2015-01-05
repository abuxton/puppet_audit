# == Class puppet_audit::directory
#
define puppet_audit::directory(
  $dirpath = "${title}",
  $dirMD5,
  $tags = '',
  )
  {
    case $tags{
    '': {
      
      dir { "${dirpath}" :
        ensure => dir,
        content => "${dirMD5}",
        noop => true,
        replace => false,
      } 
    }
    default:  {
      dir { "${dirpath}" :
        ensure => dir,
        content => "${dirMD5}",
        noop => true,
        replace => false,
        tag => "${tags}",
      }
    }
  }
}

