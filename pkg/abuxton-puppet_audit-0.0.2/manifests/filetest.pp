class puppet_audit::filetest {
  include puppet_audit

  # Setup local hashes pulling data from Hiera hashes.

  $security_files_hash = hiera_hash('profiles::puppet_audit_files',{})
  $security_directories_hash = hiera_hash('profiles::puppet_audit_directories',{})
  $security_links_hash = hiera_hash('profiles::puppet_audit_links',{})

  notify { 'hashtest':
    message => "${security_files_hash}"
  }

  notify { 'directorytest':
    message => "${security_directories_hash}"
  }

  notify { 'linktest':
    message => "${security_links_hash}"
  }

  # Check files, directories, and links using create resources function.

  create_resources('puppet_audit::file', $security_files_hash)
  create_resources('puppet_audit::directory', $security_directories_hash)
  create_resources('puppet_audit::link', $security_links_hash)

}  
