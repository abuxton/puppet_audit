# == Class puppet_audit::files
#
define puppet_audit::file(
  $fileMD5,
  $group,
  $mode,
  $owner,
  $tags = undef,
  $filepath = "${title}",
)
{
  if $tags {
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
  } else {
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
}

