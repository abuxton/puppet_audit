# == Class puppet_audit::directory
#
define puppet_audit::directory(
  $filepath = "${title}",
  $group,
  $mode,
  $owner,
  $target,
  $tags = '',
  )
  {
    case $tags{
    '': {
      
      file { "${filepath}" :
        ensure  => link,
        group   => "${group}",
        mode    => "${mode}",
        owner   => "${owner}",
        target  => "${target}",
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
        target  => "${target}",
        noop    => true,
        replace => true,
        tag     => "${tags}",
      }
    }
  }
}

