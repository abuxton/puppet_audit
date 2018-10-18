class profile::puppet_audit {
  include puppet_audit

  # Setup local hash variables pulling data from Hiera hashes.

  $security_files_hash = hiera_hash('profile::puppet_audit_files',{})
  $security_directories_hash = hiera_hash('profile::puppet_audit_directories',{})
  $security_links_hash = hiera_hash('profile::puppet_audit_links',{})

  # Check files, directories, and links using create resources function.

  create_resources('puppet_audit::file', $security_files_hash)
  create_resources('puppet_audit::directory', $security_directories_hash)
  create_resources('puppet_audit::link', $security_links_hash)
}
