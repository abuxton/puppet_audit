# == Class puppet_audit::directory
#
define puppet_audit::directory(
  $group,
  $mode,
  $owner,
  $tags = '',
  $filepath = "${title}",
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

