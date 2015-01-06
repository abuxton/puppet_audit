# == Class puppet_audit::link
#
define puppet_audit::link(
  $linkfilepath = "${title}",
  $group,
  $mode,
  $owner,
  $target,
  $tags = '',
  )
  {
    case $tags{
    '': {
      
      file { "${linkfilepath}" :
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
      file { "${linkfilepath}" :
        ensure  => link,
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

