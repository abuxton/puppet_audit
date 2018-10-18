# == Class puppet_audit::files
#
define puppet_audit::file(
  String                          $checksum,
  String                          $group,
  String                          $mode,
  String                          $owner,
  String                          $checksum_type  = 'md5',
  Optional[Variant[Array,String]] $tags           = undef,
  Stdlib::Absolutepath            $filepath       = $title,

)
{
  if $tags {
    file { $filepath :
      ensure        =>  file,
      checksum      =>  $checksum,
      checksum_type =>  $checksum_type,
      group         =>  $group,
      mode          =>  $mode,
      owner         =>  $owner,
      noop          =>  true,
      replace       =>  true,
      tag           =>  $tags,
    }
  } else {
    file { $filepath :
      ensure        =>  file,
      checksum      =>  $checksum,
      checksum_type =>  $checksum_type,
      group         =>  $group,
      mode          =>  $mode,
      owner         =>  $owner,
      noop          =>  true,
      replace       =>  true,
    }
  }
}

