# == Class puppet_audit::directory
#
define puppet_audit::directory(
  $group,
  $mode,
  $owner,
  $tags = undef,
  $filepath = "${title}",
)
{
  if $tags {
    file { "${filepath}" :
      ensure  => directory,
      group   => "${group}",
      mode    => "${mode}",
      owner   => "${owner}",
      noop    => true,
      replace => true,
      tag     => "${tags}",
    }
  } else {
    file { "${filepath}" :
      ensure  => directory,
      group   => "${group}",
      mode    => "${mode}",
      owner   => "${owner}",
      noop    => true,
      replace => true,
    }
  }
}

