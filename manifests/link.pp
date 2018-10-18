# A description of what this defined type does
#
# @summary defined type resource for auditing symlinks.
#
# @example
#   puppet_audit::alink { 'Stdlib::Absolutepath': 
#     $group  =>  String,
#     $mode   =>  String,
#     $owner  =>  String,
#     $target =>  Stdlib::Absolutepath,
#     $tags   =>  ['String'],
#   }
define puppet_audit::link(
  String                          $group,
  String                          $mode,
  String                          $owner,
  Stdlib::Absolutepath            $target,
  Optional[Variant[Array,String]] $tags         = undef,
  Stdlib::Absolutepath            $linkfilepath = $title,
)
{
  if $tags {
    file { $linkfilepath :
      ensure  => link,
      group   => $group,
      mode    => $mode,
      owner   => $owner,
      target  => $target,
      noop    => true,
      replace => true,
      tag     => $tags,
    }
  } else  {
    file { $linkfilepath :
      ensure  => link,
      group   => $group,
      mode    => $mode,
      owner   => $owner,
      target  => $target,
      noop    => true,
      replace => true,
    }
  }
}

