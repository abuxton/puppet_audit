# == Class puppet_audit::directory
#
define puppet_audit::directory(
  String                          $group,
  String                          $mode,
  String                          $owner,
  Optional[Variant[Array,String]] $tags           = undef,
  Stdlib::Absolutepath            $filepath       = $title,
)
{
  if $tags {
    file { $filepath :
      ensure  => directory,
      group   => $group,
      mode    => $mode,
      owner   => $owner,
      noop    => true,
      replace => true,
      tag     => $tags,
    }
  } else {
    file { $filepath :
      ensure  => directory,
      group   => $group,
      mode    => $mode,
      owner   => $owner,
      noop    => true,
      replace => true,
    }
  }
}

