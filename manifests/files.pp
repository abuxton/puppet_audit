# == Class puppet_audit::files
#
define puppet_audit::files(
  $filepath = "${title}",
  $fileMD5,
  $group,
  $mode,
  $owner,
  $tags = '',
  )
  {
    case $tags{
    '': {
      
      file { "${filepath}" :
        ensure  => file,
        content => "${fileMD5}",
        group   => "${group}",
        mode    => "${mode}",
        owner   => "${owner}",
        noop    => true,
        replace => true,
      } 
    }
    default:  {
      file { "${filepath}" :
        ensure  => file,
        content => "${fileMD5}",
        group   => "${group}",
        mode    => "${mode}",
        owner   => "${owner}",
        noop    => true,
        replace => true,
        tag     => "${tags}",
      }
    }
  }
}

