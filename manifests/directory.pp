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
        replace => true,
      } 
    }
    default:  {
      dir { "${dirpath}" :
        ensure => dir,
        content => "${dirMD5}",
        noop => true,
        replace => true,
        tag => "${tags}",
      }
    }
  }
}

