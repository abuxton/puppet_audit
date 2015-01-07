####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with puppet_audit](#setup)
    * [What puppet_audit affects](#what-puppet_audit-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with puppet_audit](#beginning-with-puppet_audit)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

Developed for Aramco, the puppet_audit module packages 3 defined resource types to check the presence / integrity of sensitive files, directories and symbolic links.

##Module Description

A standalone module which consumes hiera hash data pertinent to files, directories and symbolic links in the following example form:

---
'profiles::puppet_audit_files':
  '/etc/passwd':
    fileMD5: '{md5}0c4305ed79b2292299b00ebcb691a0e4'
    group: '0'
    mode: '644'
    owner: '0'
  '/etc/group':
    fileMD5: '{md5}51c9981096429f8e37696806c7b0050f'
    group: '0'
    mode: '644'
    owner: '0'
'profiles::puppet_audit_directories':
  '/etc/rc.d':
    group: '0'
    owner: '0'
    mode: '755'
  '/etc/xinetd.d':
    group: '0'
    owner: '0'
    mode: '755'
'profiles::puppet_audit_links':
  '/etc/grub.conf':
    group: '0'
    owner: '0'
    mode: '777'
    target: '../boot/grub/grub.conf'

##Setup

 Install the module from the forge and classify appropriate nodes with the profiles::puppet_audit class.

 class profiles::puppet_audit {
   include puppet_audit

  # Setup local hash variables pulling data from Hiera hashes.
   $security_files_hash = hiera_hash('profiles::puppet_audit_files',{})
   $security_directories_hash = hiera_hash('profiles::puppet_audit_directories',{})
   $security_links_hash = hiera_hash('profiles::puppet_audit_links',{})
  
  # Check files, directories, and links using create resources function.
  
   create_resources('puppet_audit::file', $security_files_hash)
   create_resources('puppet_audit::directory', $security_directories_hash)
   create_resources('puppet_audit::link', $security_links_hash)
  } 

###What puppet_audit affects

 Only the list of files, directories and symlinks specified in the appropriate hiera hashes.

###Setup Requirements **OPTIONAL**

 None.

###Beginning with puppet_audit


##Usage

puppet_audit is called via the profile: profiles::puppet_audit which declares the puppet_audit class and calls the defined resource types: puppet_audit::file, puppet_audit::directory, puppet_audit::link.
##Reference

Please see: https://docs.puppetlabs.com/hiera/1/lookup_types.html for information on encapsulating data in hiera hashes.

##Limitations

This module has been tested on Darwin [OSX] and Centos 6.5.

##Development

abuxton / dbmoore

##Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You may also add any additional sections you feel are necessary or important to include here. Please use the `## ` header. 
