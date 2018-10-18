# == Class puppet_audit::files
#
# @summary audit the file resource
# can only audit or declare, if you want to audit it then do so if you want to just use a file use a file.
#
# @example
#
#
define puppet_audit::file(
  String                          $group,
  String                          $mode,
  String                          $owner,
  Optional[String]                $source           = undef, #work out data type or regex for this to be file source compatability
  Optional[String]                $content          = undef,
  Optional[String]                $checksum         = undef,
  Optional[String]                $checksum_value   = undef,
  Optional[Variant[Array,String]] $tags             = undef,
  Stdlib::Absolutepath            $filepath         = $title,
)
{
  File{
    tag             => $tags, #this is a work around (hack) for versions of puppet where `tag` can not be decared as undef in the resource, but can in the resource default
    checksum        => $checksum,
    checksum_value  => $checksum_value,
    source          => $source,
    content         => $content,
  }


  file { $filepath :
    ensure  =>  file,
    group   =>  $group,
    mode    =>  $mode,
    owner   =>  $owner,
    noop    =>  true,
    replace =>  true,
  }
}

