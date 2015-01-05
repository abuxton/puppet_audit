# == Class puppet_audit::files
#
define puppet_audit::files(
  $filepath = "${title}",
  $group,
  $mode,
  $owner,
  $tags = '',
  )
  {
    case $tags{
    '': {
      
      file { "${filepath}" :
        ensure  => directory,
        group   => "${group}",
        mode    => "${mode}",
        owner   => "${owner}",
        noop    => true,
        replace => true,
      } 
    }
    default:  {
      file { "${filepath}" :
        ensure  => directory,
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

