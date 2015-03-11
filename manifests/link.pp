# == Class puppet_audit::link
i
#
define puppet_audit::link(
  $group,
  $mode,
  $owner,
  $target,
  $tags = undef,
  $linkfilepath = "${title}",
)
{
  if $tags {
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
  } else  {
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
}

