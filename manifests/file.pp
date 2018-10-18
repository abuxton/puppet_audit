# == Class puppet_audit::files
#
define puppet_audit::file(
  String                          $checksum_value,
  String                          $group,
  String                          $mode,
  String                          $owner,
  String                          $checksum         = 'md5',
  Optional[Variant[Array,String]] $tags             = undef,
  Stdlib::Absolutepath            $filepath         = $title,
)
{
  if $tags {
    file { $filepath :
      ensure         =>  file,
      checksum       =>  $checksum,
      checksum_value =>  $checksum_value,
      group          =>  $group,
      mode           =>  $mode,
      owner          =>  $owner,
      noop           =>  true,
      replace        =>  true,
      tag            =>  $tags,
    }
  } else {
    file { $filepath :
      ensure         =>  file,
      checksum       =>  $checksum,
      checksum_value =>  $checksum_value,
      group          =>  $group,
      mode           =>  $mode,
      owner          =>  $owner,
      noop           =>  true,
      replace        =>  true,
    }
  }
}

